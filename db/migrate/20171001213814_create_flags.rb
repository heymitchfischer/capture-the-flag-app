class CreateFlags < ActiveRecord::Migration[5.1]
  def change
    create_table :flags do |t|
      t.float :latitude
      t.float :longitude
      t.integer :team_id
      t.integer :base_id

      t.timestamps
    end
  end
end
