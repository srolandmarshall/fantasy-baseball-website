# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

TEAMS = [
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
TEAMS.each { |team| Team.create(team) }
PLAYERS_SHEET = Roo::Excelx.new('./public/yahoo_player_rankings.xlsx')
PLAYER_DATA = PLAYERS_SHEET.parse(headers: true)
PLAYER_DATA.each do |player|
  Player.find_or_create_by(
    rank: player['Rank'],
    name: player['Player'],
    position: player['Position'],
    team: player['Team'],
    adp: player['ADP'],
    avg_cost: player['Average Cost'],
  )
end
