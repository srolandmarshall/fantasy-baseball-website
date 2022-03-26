class HomeController < ApplicationController
  def index
    @draft_date ||= DateTime.parse('April 4, 2022 7PM ET')
    @teams = Team.all.sort_by { |team| team.order }
  end
end
