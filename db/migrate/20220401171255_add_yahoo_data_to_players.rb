class AddYahooDataToPlayers < ActiveRecord::Migration[7.0]
  def change
    # add column undroppable for players
    add_column :players, :undroppable, :boolean, default: false
    add_column :players, :editorial_player_key, :string, default: nil
  end
end