class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :seasonal_rates

  validates :name, :description, :dimension,
            :max_people, :daily_rate, presence: true

  def current_daily_rate
    daily_rate = self.daily_rate
    active_seasonal_rates = self.seasonal_rates.active
    active_seasonal_rates.each do |sr|
      if Date.today.between?(sr.start_date, sr.finish_date)
        return sr.rate
      end
    end

    daily_rate
  end
end
