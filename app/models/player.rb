class Player < ApplicationRecord
  PITCHER_POSITIONS = %w(SP RP P)
  
  belongs_to :team, optional: true

  def initialize(attributes = {})
    super
    self.adp = 0 if adp.blank?
    self.avg_cost = 0 if avg_cost.blank?
  end

  scope :pitchers, -> { where('position IN ?', PITCHER_POSITIONS) }

  def team
    team_id ? Team.find(team_id) : nil
  end

  def positions
    @positions ||= position.split(',')
  end

  def pitcher?
    (positions & PITCHER_POSITIONS).any?
  end

  def positions_display
    positions.join(', ')
  end

  def fantasy_team
    team ? team.name : "Undrafted"
  end

end
