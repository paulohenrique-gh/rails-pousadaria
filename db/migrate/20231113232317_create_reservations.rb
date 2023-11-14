class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.date :checkin, null: false
      t.date :checkout, null: false
      t.integer :guest_count, null: false
      t.float :stay_total, null: false
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
