class Player < ApplicationRecord
  belongs_to :team, optional: true

  PITCHER_POSITIONS = %w(SP RP P)

  scope :pitchers, -> { where("ARRAY[position]::text[] && ARRAY[?]::text[]", PITCHER_POSITIONS)}
  scope :batters, -> { where.not("ARRAY[position]::text[] && ARRAY[?]::text[]", PITCHER_POSITIONS)}

  def self.by_position(positions)
    Player.where("ARRAY[position]::text[] && ARRAY[?]::text[]", [positions].flatten)
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

end
