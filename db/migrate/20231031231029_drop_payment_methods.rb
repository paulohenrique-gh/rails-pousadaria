class DropPaymentMethods < ActiveRecord::Migration[7.1]
  def change
    drop_table :payment_methods
  end
end
