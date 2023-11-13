class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :seasonal_rates

  validates :name, :description, :dimension,
            :max_people, :daily_rate, presence: true

  def current_daily_rate
    SeasonalRate.active.where(room_id: self.id)
                       .where('? BETWEEN start_date AND finish_date', Date.today)
                       .pluck(:rate)
                       .first || self.daily_rate
  end
end
