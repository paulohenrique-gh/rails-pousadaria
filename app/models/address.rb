class Address < ApplicationRecord
  has_one :guesthouse

  validates :street_name, :number, :neighbourhood,
            :city, :state, :postal_code, presence: true

  scope :available_cities, -> {
    distinct.where(id: Guesthouse.active.pluck(:address_id)).pluck(:city).sort
  }
end
