class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :guest
  has_one :guesthouse, through: :room

  before_validation :generate_code, on: :create

  validates :checkin, :checkout, :guest_count, :stay_total, presence: true
  validates :checkin, comparison: { greater_than: Date.today }
  validates :checkout, comparison: { greater_than: :checkin }
  validates :guest_count, :stay_total, comparison: { greater_than: 0 }
  validate :check_room_capacity

  enum status: { active: 0, inactive: 1 }

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
