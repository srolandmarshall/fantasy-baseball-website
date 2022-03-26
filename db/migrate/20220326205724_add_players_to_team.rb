class AddPlayersToTeam < ActiveRecord::Migration[7.0]
  def change
    add_reference :teams, :players, foreign_key: true
  end
end
