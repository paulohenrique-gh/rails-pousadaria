class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :seasonal_rates
  has_many :reservations

  validates :name, :description, :dimension,
            :max_people, :daily_rate, presence: true

  def current_daily_rate
    SeasonalRate.active
                .where(room_id: self.id)
                .where('? BETWEEN start_date AND finish_date', Date.today)
                .pluck(:rate)
                .first || self.daily_rate
  end

  def available_for_reservation?(checkin_time, checkout_time)
    reservations = self.reservations
                       .where(":in BETWEEN checkin AND checkout OR "\
                              ":out BETWEEN checkin AND checkout OR "\
                              "checkin BETWEEN :in AND :out OR "\
                              "checkout BETWEEN :in AND :out",
                              in: checkin_time, out: checkout_time)

    reservations.empty?
  end
end
