class Reservation < ApplicationRecord
  MAX_DAYS_FOR_CANCELLING_BEFORE_CHECKIN = 7

  belongs_to :room
  belongs_to :guest, optional: true
  has_one :guesthouse, through: :room

  before_validation :generate_code, on: :create

  validates :checkin, :checkout, :guest_count, :stay_total, presence: true
  validates :checkin, comparison: { greater_than: Date.today }
  validates :checkout, comparison: { greater_than: :checkin }
  validates :guest_count, comparison: { greater_than: 0 }
  validates :code, uniqueness: true, on: :create
  validate :check_room_capacity

  enum status: { active: 0, inactive: 1, guests_checked_in: 2, guests_checked_out: 3 }

  def elligible_for_cancellation?
    days_before_checkin = (self.checkin.to_date - Date.today).to_i
    days_before_checkin >= MAX_DAYS_FOR_CANCELLING_BEFORE_CHECKIN
  end

  def cancel
    self.inactive! if elligible_for_cancellation?
  end

  def elligible_for_checkin?
    Date.today.between?(self.checkin, self.checkout) && self.active?
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
