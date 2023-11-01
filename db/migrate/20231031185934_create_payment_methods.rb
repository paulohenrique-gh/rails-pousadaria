class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.integer :method, default: 0
      t.references :guesthouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
