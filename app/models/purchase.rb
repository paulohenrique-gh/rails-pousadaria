class Purchase < ApplicationRecord
  belongs_to :reservation

  validates :product_name, :price, :quantity, presence: true
  validates :price, comparison: { greater_than_or_equal_to: 0.01 }
  validates :quantity, comparison: { greater_than_or_equal_to: 1 }
end
