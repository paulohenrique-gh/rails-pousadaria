class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street_name, null: false
      t.string :number, null: false
      t.string :complement
      t.string :neighbourhood, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :postal_code, null: false
      t.references :guesthouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
