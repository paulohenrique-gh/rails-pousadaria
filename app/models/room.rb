class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :seasonal_rates
  has_many :reservations
  has_many_attached :pictures

  validates :name, :description, :dimension,
            :max_people, :daily_rate, presence: true
  validates :dimension, :daily_rate, comparison: { greater_than_or_equal_to: 0.01 }
  validates :max_people, comparison: { greater_than_or_equal_to: 1 }
  validate :file_format_must_be_jpeg_or_png

  def current_daily_rate
    self.seasonal_rates
        .active
        .find_by('? BETWEEN start_date AND finish_date', Date.today)
        .try(:rate) || self.daily_rate
  end

  def booked?(checkin_date, checkout_date)
    conflicts = self.reservations
                    .where(status: [:confirmed, :guests_checked_in])
                    .where(":in BETWEEN checkin AND checkout OR "\
                            ":out BETWEEN checkin AND checkout OR "\
                            "checkin BETWEEN :in AND :out OR "\
                            "checkout BETWEEN :in AND :out",
                            in: checkin_date, out: checkout_date)

    conflicts.any?
  end
end
