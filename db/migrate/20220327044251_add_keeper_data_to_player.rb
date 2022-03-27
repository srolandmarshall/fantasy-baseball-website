class AddKeeperDataToPlayer < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :is_keeper, :boolean
  end
end
