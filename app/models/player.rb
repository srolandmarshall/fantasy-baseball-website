class Player < ApplicationRecord
  PITCHER_POSITIONS = %w(SP RP P)
  
  belongs_to :team, optional: true

  def initialize(attributes = {})
    super
    self.adp = 0 if adp.blank?
    self.avg_cost = 0 if avg_cost.blank?
  end

  def team
    team_id ? Team.find(team_id) : nil
  end

  def pitcher?
    (position & PITCHER_POSITIONS).any?
  end

  def self.pitchers
    @pitchers ||= Player.all.filter {|player| player.pitcher?}
  end

  def self.batters
    @hitters ||= Player.all.filter {|player| !player.pitcher?}
  end

  def positions_display
    position.join(', ')
  end

  def fantasy_team
    team ? team.name : "Undrafted"
  end

end
