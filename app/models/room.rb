class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :seasonal_rates

  validates :name, :description, :dimension,
            :max_people, :daily_rate, presence: true
end
