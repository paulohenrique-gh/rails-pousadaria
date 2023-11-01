class RemoveAddressIdFromGuesthouses < ActiveRecord::Migration[7.1]
  def change
    remove_column :guesthouses, :address_id
  end
end
