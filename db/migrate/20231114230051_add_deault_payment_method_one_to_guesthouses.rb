class AddDeaultPaymentMethodOneToGuesthouses < ActiveRecord::Migration[7.1]
  def change
    change_column_default :guesthouses, :payment_method_one, from: nil, to: 'Dinheiro'
  end
end
