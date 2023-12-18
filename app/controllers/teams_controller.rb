class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @past_games = @team.past_games
    @players = @team.sort_players(:rating).reject { |player| player.average[:min].zero? }
  end
end
