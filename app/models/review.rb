class Review < ApplicationRecord
  belongs_to :reservation

  validates :rating, :description, presence: true
end
