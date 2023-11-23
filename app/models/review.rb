class Review < ApplicationRecord
  belongs_to :reservation
  has_one :guest, through: :reservation

  validates :rating, :description, presence: true
  validates :response, presence: true, on: :update
end
