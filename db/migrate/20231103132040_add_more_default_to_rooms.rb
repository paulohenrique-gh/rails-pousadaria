class AddMoreDefaultToRooms < ActiveRecord::Migration[7.1]
  def change
    change_column_default :rooms, :private_bathroom, default: false
    change_column_default :rooms, :balcony, default: false
    change_column_default :rooms, :air_conditioning, default: false
    change_column_default :rooms, :tv, default: false
    change_column_default :rooms, :closet, default: false
    change_column_default :rooms, :safe, default: false
    change_column_default :rooms, :accessibility, default: false
  end
end
