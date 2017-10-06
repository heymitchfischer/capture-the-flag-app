class CreateStuns < ActiveRecord::Migration[5.1]
  def change
    create_table :stuns do |t|
      t.integer :stunner_id
      t.integer :stunnee_id

      t.timestamps
    end
  end
end
