class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @past_games = @team.past_games(@team)
    @players = @team.sort_players(@team, :min)
  end
end
