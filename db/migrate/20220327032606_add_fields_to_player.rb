class AddFieldsToPlayer < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :first_name, :string
    add_column :players, :last_name, :string
    add_column :players, :full_name, :string
    add_column :players, :portrait_url, :text
    add_column :players, :yahoo_player_id, :string
    add_column :players, :yahoo_player_key, :string

    Player.all.each do |player|
      player.update!(
        first_name: player.name&.split(', ').last,
        last_name: player.name&.split(', ').first,
        full_name: "#{player.name&.split(', ').last} #{player.name.split(', ').first}"
      )
    end
  end
end
