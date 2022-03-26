class Player < ApplicationRecord
  belongs_to :team, optional: true

  def team
    team_id ? Team.find(team_id) : nil
  end

  def fantasy_team
    team ? team.name : "Undrafted"
  end

end
