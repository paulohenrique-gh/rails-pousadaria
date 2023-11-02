class AddAddressToGuesthouses < ActiveRecord::Migration[7.1]
  def change
    add_reference :guesthouses, :address, null: false, foreign_key: true
  end
end
