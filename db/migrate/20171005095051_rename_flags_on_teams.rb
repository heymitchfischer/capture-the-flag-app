class RenameFlagsOnTeams < ActiveRecord::Migration[5.1]
  def change
    rename_column :teams, :flags, :score
  end
end
