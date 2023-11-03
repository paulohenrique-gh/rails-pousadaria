class Room < ApplicationRecord
  belongs_to :guesthouse

  validates :name, :description, :dimension,
            :max_people, :daily_rate, presence: true
end
