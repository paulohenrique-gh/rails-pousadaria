class SeasonalRate < ApplicationRecord
  belongs_to :room

  enum status: { active: 0, inactive: 1 }

  validates :start_date, :finish_date, :rate, presence: true
  validates :finish_date, comparison: { greater_than_or_equal_to: :start_date,
                          message: 'não pode ser menor que data inicial' }
  validate :dates_do_not_overlap

  scope :overlapping_dates, ->(id, date) {
    active.where.not(id: id)
          .where('? BETWEEN start_date AND finish_date', date)
  }

  private

  def dates_do_not_overlap
    start_date_overlap = SeasonalRate.overlapping_dates(self.id, self.start_date)
    if start_date_overlap.any?
      self.errors.add(:start_date, 'dentro de período já cadastrado')
    end

    finish_date_overlap = SeasonalRate.overlapping_dates(self.id, self.finish_date)
    if finish_date_overlap.any?
      self.errors.add(:finish_date, 'dentro de período já cadastrado')
    end
  end
end
