class AddTimeStunToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :time_stunned, :datetime
  end
end
