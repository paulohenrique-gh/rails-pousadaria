class PaymentMethod < ApplicationRecord
  belongs_to :guesthouse

  enum method: { cash: 0, pix: 2, credit_card: 4 }
end
