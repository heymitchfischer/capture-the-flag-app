class AddHasFlagToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :has_flag, :boolean
  end
end
