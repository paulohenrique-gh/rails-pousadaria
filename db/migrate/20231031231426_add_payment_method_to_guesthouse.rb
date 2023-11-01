class AddPaymentMethodToGuesthouse < ActiveRecord::Migration[7.1]
  def change
    add_column :guesthouses, :payment_method_one, :string
    add_column :guesthouses, :payment_method_two, :string
    add_column :guesthouses, :payment_method_three, :string
  end
end
