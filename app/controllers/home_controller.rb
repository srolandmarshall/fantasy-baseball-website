class HomeController < ApplicationController
  def index
    @draft_date ||= DateTime.parse('April 5, 2022 7PM ET')
    @teams = Team.all.sort_by { |team| team.order }
    @rules = Rule.all.sort_by { |rule| rule.order }
  end
end
