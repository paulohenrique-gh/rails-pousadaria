class Reservation < ApplicationRecord
  GUEST_MAX_DAYS_BEFORE_CHECKIN = 7
  USER_MIN_DAYS_AFTER_CHECKIN = 2
  TIME_FORMAT = '%H:%M:%S'

  belongs_to :room
  belongs_to :guest, optional: true
  has_one :guesthouse, through: :room

  before_validation :generate_code, on: :create

  validates :checkin, :checkout, :guest_count, :stay_total, presence: true
  validates :checkin, comparison: { greater_than: Date.today }, on: [:create]
  validates :checkout, comparison: { greater_than: :checkin }
  validates :guest_count, comparison: { greater_than: 0 }
  validates :code, uniqueness: true, on: :create
  validate :check_room_capacity

  enum status: { confirmed: 0, cancelled: 1,
                 guests_checked_in: 2, guests_checked_out: 3 }

  def elligible_for_cancellation_by_guest?
    days_before_schedule = (self.checkin.to_date - Date.today).to_i
    days_before_schedule >= GUEST_MAX_DAYS_BEFORE_CHECKIN && self.confirmed?
  end

  def guest_cancel
    self.cancelled! if elligible_for_cancellation_by_guest?
  end

  def elligible_for_cancellation_by_user?
    days_after_schedule = (Date.today - self.checkin.to_date).to_i
    days_after_schedule >= USER_MIN_DAYS_AFTER_CHECKIN && self.confirmed?
  end

  def user_cancel
    self.cancelled! if elligible_for_cancellation_by_user?
  end

  def elligible_for_checkin?
    Date.today.between?(self.checkin, self.checkout) && self.confirmed?
  end

  def guests_checked_in!
    return false unless elligible_for_checkin?
    self.update(status: :guests_checked_in, checked_in_at: DateTime.now)
  end

  def guests_checked_out!
    return false if self.payment_method.nil? || !self.guests_checked_in?
    self.update(status: :guests_checked_out, checked_out_at: DateTime.now)
  end

  def calculate_stay_total(checkin, checkout)
    stay_total = 0
    (checkin..checkout).each do |date|
      seasonal_rate = self.room.seasonal_rates.active
                          .find_by('? BETWEEN start_date AND finish_date', date)

      stay_total += seasonal_rate.try(:rate) || self.room.daily_rate
    end

    stay_total
  end

  def reprocess_stay_total
    raise 'Reserva sem check-in registrado' unless self.guests_checked_in?

    current_time = Time.now.strftime(TIME_FORMAT)
    standard_checkout_time = self.guesthouse.checkout_time.strftime(TIME_FORMAT)

    actual_checkin = self.checked_in_at.to_date
    actual_checkout = Date.today
    actual_checkout += 1 if current_time > standard_checkout_time

    calculate_stay_total(actual_checkin, actual_checkout)
  end

  private

  def check_room_capacity
    if self.guest_count.present? && self.guest_count > self.room.max_people
      self.errors.add(:guest_count, 'excede capacidade do quarto')
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
