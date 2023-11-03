class ChangeDefaultInRooms < ActiveRecord::Migration[7.1]
  def change
    change_column :rooms, :private_bathroom, :boolean, default: false
    change_column :rooms, :balcony, :boolean, default: false
    change_column :rooms, :air_conditioning, :boolean, default: false
    change_column :rooms, :tv, :boolean, default: false
    change_column :rooms, :closet, :boolean, default: false
    change_column :rooms, :safe, :boolean, default: false
    change_column :rooms, :accessibility, :boolean, default: false
  end
end
