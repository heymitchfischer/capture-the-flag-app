class CreateBases < ActiveRecord::Migration[5.1]
  def change
    create_table :bases do |t|
      t.integer :team_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
