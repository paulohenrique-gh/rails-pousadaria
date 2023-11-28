class Purchase < ApplicationRecord
  belongs_to :reservation

  validates :product_name, :price, :quantity, presence: true
end
