class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @past_games = @team.past_games(@team)
    @players = @team.sort_players(@team, :rating).reject { |player| player.average(player.stats, player)[:min].zero? }
  end
end
