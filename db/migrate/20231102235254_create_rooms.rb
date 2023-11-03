class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.float :dimension
      t.integer :max_people
      t.float :daily_rate
      t.boolean :private_bathroom
      t.boolean :balcony
      t.boolean :air_conditioning
      t.boolean :tv
      t.boolean :closet
      t.boolean :safe
      t.boolean :accessibility
      t.boolean :available

      t.timestamps
    end
  end
end
