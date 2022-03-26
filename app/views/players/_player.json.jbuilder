json.extract! player, :id, :rank, :name, :position, :team, :adp, :avg_cost, :created_at, :updated_at
json.url player_url(player, format: :json)
