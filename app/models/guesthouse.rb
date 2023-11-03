class Guesthouse < ApplicationRecord
  belongs_to :address
  belongs_to :user
  has_many :rooms

  validates :brand_name, :corporate_name, :registration_number, :phone_number,
            :email, presence: true

  enum status: { active: 0, inactive: 1 }

  accepts_nested_attributes_for :address
end
