class Guesthouse < ApplicationRecord
  has_one :address
  belongs_to :user

  validates :brand_name, :corporate_name, :registration_number, :phone_number,
            :email, presence: true

  accepts_nested_attributes_for :address
end
