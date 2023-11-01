class CreateGuesthouses < ActiveRecord::Migration[7.1]
  def change
    create_table :guesthouses do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :registration_number
      t.string :phone_number
      t.string :email
      t.text :description
      t.integer :pet_policy
      t.text :guesthouse_policy
      t.time :checkin_time
      t.time :checkout_time

      t.timestamps
    end
  end
end
