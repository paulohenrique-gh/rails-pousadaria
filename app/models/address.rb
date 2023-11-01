class Address < ApplicationRecord
  belongs_to :guesthouse

  validates :street_name, :number, :neighbourhood,
            :city, :state, :postal_code, presence: true
end
