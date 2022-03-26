class AddTeamToPlayer < ActiveRecord::Migration[7.0]
  def change
    rename_column :players, :team, :mlb_team
    add_reference :players, :team, null: true, foreign_key: true
  end
end
