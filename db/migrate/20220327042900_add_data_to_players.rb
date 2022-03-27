class AddDataToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :last_year_draft, :string
    add_column :players, :last_year_end_rank, :integer
    add_column :players, :current_o_rank, :integer
    add_column :players, :status, :string

    puts 'Importing Last Year Roster Data'
    sheet = Roo::Excelx.new('./public/2021_end_rosters.xlsx')
    data = sheet.parse(headers: true)
    data.each_with_index do |roster, index|
      next if index == 0

      player = Player.find_by(full_name: roster['Player'])
      if player
        player.update!(
          last_year_draft: roster['2021 Draft Position'],
          last_year_end_rank: roster['2021 Final Rank'],
          current_o_rank: roster['Current O-Rank'],
          status: roster['Status']
        )
      end
    end
  end
end
