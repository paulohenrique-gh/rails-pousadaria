class RemoveGuesthouseIdFromAddresses < ActiveRecord::Migration[7.1]
  def change
    remove_column :addresses, :guesthouse_id
  end
end
