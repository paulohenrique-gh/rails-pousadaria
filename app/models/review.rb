class Review < ApplicationRecord
  belongs_to :reservation

  validates :rating, :description, presence: true
  validates :response, presence: true, on: :update
end
