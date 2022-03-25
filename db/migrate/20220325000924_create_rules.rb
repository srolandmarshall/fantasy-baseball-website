class CreateRules < ActiveRecord::Migration[7.0]
  def change
    create_table :rules do |t|
      t.integer :order
      t.text :text

      t.timestamps
    end
  end
end
