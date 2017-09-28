class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :password_confirmation
      t.integer :team_id
      t.integer :points
      t.integer :latitude
      t.integer :longitude

      t.timestamps
    end
  end
end
