class Player < ApplicationRecord
  belongs_to :team, optional: true

  PITCHER_POSITIONS = %w(SP RP P)

  scope :pitchers, -> { where("ARRAY[position]::text[] && ARRAY[?]::text[]", PITCHER_POSITIONS)}
  scope :batters, -> { where.not("ARRAY[position]::text[] && ARRAY[?]::text[]", PITCHER_POSITIONS)}
  scope :keepers, -> { where(is_keeper: true) }

  def self.by_position(positions)
    Player.where("ARRAY[position]::text[] && ARRAY[?]::text[]", [positions].flatten).order(:rank)
  end

  def team
    team_id ? Team.find(team_id) : nil
  end

  def positions_display
    position.join(', ')
  end

  def fantasy_team
    team ? team.name : "Undrafted"
  end

  def last_year_team
    Team.find(last_year_team_id)
  end

  def self.positions
    @positions ||= Player.all.map {|player| player.position}.flatten.uniq
  end
  
  def update_from_yahoo_data!(player_data = {})
    attributes = {
      undroppable: ActiveModel::Type::Boolean.new.cast(player_data["is_undroppable"]),
      yahoo_player_id: player_data["player_id"],
      yahoo_player_key: player_data["player_key"],
      editorial_player_key: player_data["editorial_player_key"],
      portrait_url: player_data["image_url"]
    }
    puts "Updating #{player_data["name"]["full"]}"
    update!(attributes)
  end

end
