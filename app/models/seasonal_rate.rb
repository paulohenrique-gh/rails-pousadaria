class SeasonalRate < ApplicationRecord
  belongs_to :room

  validates :start_date, :finish_date, :rate, presence: true
  validate :finish_date_is_greater_than_start_date

  private

  def finish_date_is_greater_than_start_date
    if self.start_date.present? && self.finish_date.present? &&
       self.finish_date < self.start_date
      self.errors.add(:finish_date, 'não pode ser menor que data inicial')
    end
  end
end
