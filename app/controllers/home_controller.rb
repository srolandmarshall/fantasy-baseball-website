class HomeController < ApplicationController
  before_action :set_zoom_url

  def index
    @draft_date ||= DateTime.parse('April 5, 2022 7PM ET')
    @teams = Team.all.sort_by { |team| team.order }
    @rules = Rule.all.sort_by { |rule| rule.order }
    @keepers = Player.keepers.order(:team_id, :draft_round, :draft_pick_number)
  end
  
  def zoom
    redirect_to @zoom_url, allow_other_host: true, status: 302
  end

  def set_zoom_url
    @zoom_url ||= ENV['ZOOM_URL'] || Rails.application.credentials&.zoom[:url]
  end
  
end
