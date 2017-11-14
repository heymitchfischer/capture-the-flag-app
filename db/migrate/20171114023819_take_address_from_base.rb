class TakeAddressFromBase < ActiveRecord::Migration[5.1]
  def change
    remove_column :bases, :address, :string
  end
end
