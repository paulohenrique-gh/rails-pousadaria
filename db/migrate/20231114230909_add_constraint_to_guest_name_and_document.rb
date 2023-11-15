class AddConstraintToGuestNameAndDocument < ActiveRecord::Migration[7.1]
  def change
    change_column_null :guests, :name, false
    change_column_null :guests, :document, false
  end
end
