class SeasonalRate < ApplicationRecord
  belongs_to :room

  enum status: { active: 0, inactive: 1 }

  validates :start_date, :finish_date, :rate, presence: true
  validates :start_date, comparison: { greater_than_or_equal_to: Date.today }
  validates :finish_date, comparison: { greater_than_or_equal_to: :start_date,
                          message: 'não pode ser menor que data inicial' }
  validates :rate, comparison: { greater_than_or_equal_to: 0.01 }
  validate :dates_do_not_overlap

  scope :overlapping_dates, ->(room_id, rate_id, date) {
    active.where(room_id: room_id)
          .where.not(id: rate_id)
          .where('? BETWEEN start_date AND finish_date', date)
  }

  def inactive!
    unless self.room.booked?(self.start_date, self.finish_date)
      return super
    else
      false
    end
  end

  private

  def dates_do_not_overlap
    start_date_overlap = SeasonalRate.overlapping_dates(self.room_id,
                                                        self.id, self.start_date)
    if start_date_overlap.any?
      self.errors.add(:start_date, 'dentro de período já cadastrado')
    end

    finish_date_overlap = SeasonalRate.overlapping_dates(self.room_id,
                                                         self.id, self.finish_date)
    if finish_date_overlap.any?
      self.errors.add(:finish_date, 'dentro de período já cadastrado')
    end
  end
end
