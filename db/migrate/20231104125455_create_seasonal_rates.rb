class CreateSeasonalRates < ActiveRecord::Migration[7.1]
  def change
    create_table :seasonal_rates do |t|
      t.date :start_date, null: false
      t.date :finish_date, null: false
      t.float :rate, null: false
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
