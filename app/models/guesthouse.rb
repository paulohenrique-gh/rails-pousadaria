class Guesthouse < ApplicationRecord
  belongs_to :address
  belongs_to :user
  has_many :rooms
  has_many :reservations, through: :rooms

  validates :brand_name, :corporate_name, :registration_number, :phone_number,
            :email, :checkin_time, :checkout_time, presence: true
  validates :phone_number, length: { in: 10..11 }

  enum status: { active: 0, inactive: 1 }

  accepts_nested_attributes_for :address

  def self.quick_search(query)
    Guesthouse.active
              .joins(:address)
              .where("guesthouses.brand_name LIKE :query OR "\
                     "addresses.neighbourhood LIKE :query OR "\
                     "addresses.city LIKE :query",
                     query: "%#{query}%")
              .order(:brand_name)
  end

  def self.advanced_search(guesthouse_params, address_params, room_params)
    matching_guesthouses = Guesthouse.active
    guesthouse_params.each_pair do |k, v|
      matching_guesthouses = matching_guesthouses.where("#{k} LIKE ?", "%#{v}%")
    end

    if address_params.empty? && room_params.empty?
      return matching_guesthouses.order(:brand_name)
    end

    matching_addresses = Address.where(guesthouse: matching_guesthouses)
    address_params.each_pair do |k, v|
      matching_addresses = matching_addresses.where("#{k} LIKE ?", "%#{v}%")
    end

    if room_params.empty?
      return matching_guesthouses.where(address: matching_addresses)
                                 .order(:brand_name)
    end

    matching_rooms = Room.where(room_params)
                         .where(guesthouse: matching_guesthouses)

    matching_guesthouses.where(address: matching_addresses)
                        .where(rooms: matching_rooms)
                        .order(:brand_name)
  end
end
