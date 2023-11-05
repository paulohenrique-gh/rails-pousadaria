class SeasonalRate < ApplicationRecord
  belongs_to :room

  enum status: { active: 0, inactive: 1 }

  validates :start_date, :finish_date, :rate, presence: true
  validate :finish_date_is_greater_than_start_date, :dates_do_not_overlap

  private

  def dates_present?
    self.start_date.present? && self.finish_date.present?
  end

  def finish_date_is_greater_than_start_date
    if dates_present? && self.finish_date < self.start_date
      self.errors.add(:finish_date, 'não pode ser menor que data inicial')
    end
  end

  def check_overlap_in_dates(seasonal_rate)
    if self.start_date.between?(seasonal_rate.start_date,
                                seasonal_rate.finish_date)
      self.errors.add(:start_date, 'dentro de período já cadastrado')
    end

    if self.finish_date.between?(seasonal_rate.start_date,
                                 seasonal_rate.finish_date)
      self.errors.add(:finish_date, 'dentro de período já cadastrado')
    end
  end

  def dates_do_not_overlap
    if dates_present?
      SeasonalRate.active.where(room_id: self.room_id).
                          where.not(id: self.id).each do |sr|
        check_overlap_in_dates(sr)

        if self.errors.include?(:start_date) ||
           self.errors.include?(:finish_date)
          return
        end
      end
    end
  end
end
