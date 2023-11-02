class Address < ApplicationRecord
  has_one :guesthouse

  validates :street_name, :number, :neighbourhood,
            :city, :state, :postal_code, presence: true
end
