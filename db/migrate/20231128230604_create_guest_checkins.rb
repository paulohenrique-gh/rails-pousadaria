class CreateGuestCheckins < ActiveRecord::Migration[7.1]
  def change
    create_table :guest_checkins do |t|
      t.string :guest_name
      t.string :document
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
