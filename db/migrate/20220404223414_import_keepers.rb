class ImportKeepers < ActiveRecord::Migration[7.0]
  def change
    keepers_sheet = Roo::Excelx.new('./public/keepers.xlsx')
    keepers = keepers_sheet.parse(headers:true)
    keepers.shift # drop first element in the array, which is the header row
    keepers.each do |keeper|
      player = Player.find_by(full_name: keeper["Player"])
      if player
        player.update({
            is_keeper: true,
            draft_round: keeper["draft_round"],
            draft_pick_number: keeper["draft_pick"],
            team_id: keeper["team_id"]
          })
      else
        puts "No player for #{keeper["Player"]}"
      end
    end
  end
end
