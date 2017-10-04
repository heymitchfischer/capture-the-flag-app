class ChangeCoordinatesOnUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :latitude, :float
    change_column :users, :longitude, :float
  end
end
