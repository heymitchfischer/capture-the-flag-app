class CreateCaptures < ActiveRecord::Migration[5.1]
  def change
    create_table :captures do |t|
      t.integer :flag_id
      t.integer :user_id
      t.datetime :dropped_time
      t.boolean :success

      t.timestamps
    end
  end
end
