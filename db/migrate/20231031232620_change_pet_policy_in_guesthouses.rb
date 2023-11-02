class ChangePetPolicyInGuesthouses < ActiveRecord::Migration[7.1]
  def change
    change_column :guesthouses, :pet_policy, :boolean
  end
end
