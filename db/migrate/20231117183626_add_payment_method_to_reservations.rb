class AddPaymentMethodToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :payment_method, :string
  end
end
