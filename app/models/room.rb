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

  def available_for_reservation?(checkin_date, checkout_date)
    overlapping_reservations = self.reservations
                              .where(status: [:confirmed, :guests_checked_in])
                              .where(":in BETWEEN checkin AND checkout OR "\
                                      ":out BETWEEN checkin AND checkout OR "\
                                      "checkin BETWEEN :in AND :out OR "\
                                      "checkout BETWEEN :in AND :out",
                                      in: checkin_date, out: checkout_date)

    overlapping_reservations.empty?
  end
end
