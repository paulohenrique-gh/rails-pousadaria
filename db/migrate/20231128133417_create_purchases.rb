class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.string :product_name
      t.float :price
      t.integer :quantity
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
