# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# fantasy teams
puts "Creating Fantasy Teams"
FANTASY_TEAMS = [
  {order: 12, name: 'Fresh prince'},
  {order: 11, name: 'Bobby Bonilla\'s IRA'},
  {order: 10, name: 'Marsh\'n Monsters'},
  {order: 9, name: 'Yiplords '},
  {order: 8, name: 'Cafe Patron'},
  {order: 7, name: 'Pavia & Pete'},
  {order: 6, name: 'Ash Brew Crew'},
  {order: 5, name: 'McNeil 4 Your King'},
  {order: 4, name: 'Jameis\'s 1.08 ERA'},
  {order: 3, name: 'Air Yordan'},
  {order: 2, name: 'Purple Hayes'},
  {order: 1, name: 'Jordany Valdespins'}
]
FANTASY_TEAMS.each { |team| Team.find_or_create_by(team) }

# players
puts 'Creating MLB players...'
PLAYERS_SHEET = Roo::Excelx.new('./public/yahoo_player_rankings.xlsx')
PLAYER_DATA = PLAYERS_SHEET.parse(headers: true)
PLAYER_DATA.each_with_index do |player, index|
  next if index == 0
  
  Player.find_or_create_by(
    rank: player['Rank'],
    name: player['Player'],
    position: player['Position'].split(','),
    mlb_team: player['Team'],
    team_id: nil,
    adp: player['ADP'],
    avg_cost: player['Average Cost']
  )

  puts 'Importing Last Year Roster Data'
  ROSTER_SHEET = Roo::Excelx.new('./public/2021_end_rosters.xlsx')
  ROSTER_DATA = ROSTER_SHEET.parse(headers: true)
  ROSTER_DATA.each_with_index do |roster, index|
    next if index == 0

    Player.find_by(name: roster['Player']).update!(
      last_year_draft: roster['2021 Draft Position'],
      last_year_end_rank: roster['2021 Final Rank'],
      current_o_rank: roster['Current O-Rank'],
      status: roster['Status']
    )
  end

end
