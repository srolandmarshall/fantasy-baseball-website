class AddDraftPositionToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :draft_round, :integer
    add_column :players, :draft_position, :integer
    add_column :players, :draft_pick_number, :integer
  end
end
