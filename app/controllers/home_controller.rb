class HomeController < ApplicationController
  def index
    @draft_date ||= DateTime.parse('April 5, 2022 7PM ET')
    @teams = Team.all.sort_by { |team| team.order }
    @rules = Rule.all.sort_by { |rule| rule.order }
  end
  
  def zoom
    zoom_url = Rails.application.credentials.zoom[:url] || ENV['ZOOM_URL']
    redirect_to zoom_url, allow_other_host: true, status: 302
  end
end
