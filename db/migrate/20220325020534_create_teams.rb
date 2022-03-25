class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.integer :order
      t.string :name
      t.string :owners
      t.text :description

      t.timestamps
    end
  end
end
