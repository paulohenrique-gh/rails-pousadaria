class AddGuestToReservations < ActiveRecord::Migration[7.1]
  def change
    add_reference :reservations, :guest, null: false, foreign_key: true
  end
end
