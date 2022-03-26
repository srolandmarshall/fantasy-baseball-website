class ChangePositionsToArray < ActiveRecord::Migration[7.0]
  def change
    change_column :players, :position, :string, array: true, default: [], using: "(string_to_array(position, ','))"
  end
end
