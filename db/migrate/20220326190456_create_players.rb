class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.integer :rank
      t.string :name
      t.string :position
      t.string :team
      t.float :adp
      t.float :avg_cost

      t.timestamps
    end
  end
end
