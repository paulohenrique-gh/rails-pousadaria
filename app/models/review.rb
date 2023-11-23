class Review < ApplicationRecord
  belongs_to :reservation
  has_one :guest, through: :reservation
  has_one :guesthouse, through: :reservation

  validates :rating, :description, presence: true
  validates :response, presence: true, on: :update
  validate :check_reservation_status

  private

  def check_reservation_status
    unless self.reservation.guests_checked_out?
      self.errors.add(:base, :invalid,
                      message: 'Reserva com status diferente de concluído')
    end
  end
end
