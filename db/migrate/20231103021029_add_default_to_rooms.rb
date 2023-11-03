class AddDefaultToRooms < ActiveRecord::Migration[7.1]
  def change
    change_column_default :rooms, :available, default: true
  end
end
