class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :seasonal_rates
  has_many :reservations

  validates :name, :description, :dimension,
            :max_people, :daily_rate, presence: true

  def current_daily_rate
    self.seasonal_rates
        .active
        .find_by('? BETWEEN start_date AND finish_date', Date.today)
        .try(:rate) || self.daily_rate
  end

  def calculate_stay_total(checkin_date, checkout_date)
    stay_total = 0
    (checkin_date..checkout_date).each do |date|
      seasonal_rate = self.seasonal_rates
                          .active
                          .find_by('? BETWEEN start_date AND finish_date', date)
      stay_total += seasonal_rate.try(:rate) || self.daily_rate
    end

    stay_total
  end

  def available_for_reservation?(checkin_date, checkout_date)
    reservations = self.reservations
                       .where(status: [:active, :guests_checked_in])
                       .where(":in BETWEEN checkin AND checkout OR "\
                              ":out BETWEEN checkin AND checkout OR "\
                              "checkin BETWEEN :in AND :out OR "\
                              "checkout BETWEEN :in AND :out",
                              in: checkin_date, out: checkout_date)

    reservations.empty?
  end
end
