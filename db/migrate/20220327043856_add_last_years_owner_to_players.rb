class AddLastYearsOwnerToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :last_year_team_id, :integer

    puts 'Importing Last Year Team ID'
    sheet = Roo::Excelx.new('./public/2021_end_rosters.xlsx')
    data = sheet.parse(headers: true)
    data.each_with_index do |roster, index|
      next if index == 0

      player = Player.find_by(full_name: roster['Player'])
      if player
        player.update!(
        last_year_team_id: roster['Team ID']
        )
      end
    end
  end
end
