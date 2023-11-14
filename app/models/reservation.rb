class Reservation < ApplicationRecord
  belongs_to :room

  validates :checkin, :checkout, :guest_count, :stay_total, presence: true
  validates :checkin, comparison: { greater_than: Date.today }
  validates :checkout, comparison: { greater_than: :checkin }
  validates :guest_count, :stay_total, numericality: { greater_than: 0 }
  validate :check_room_capacity

  private

  def check_room_capacity
    if self.guest_count.present? && self.guest_count > self.room.max_people
      self.errors.add(:guest_count, 'excede capacidade do quarto')
    end
  end
end
