class GamesController < ApplicationController

  def index
    @games = Game.all
    games_array = []
    @games_final = []
    
    @games.each do |game|
      game_hash = { game_date: game.date, game: game }
      games_array << game_hash

      @games_final = games_array.group_by { |h| h[:game_date] }
      @games_final = @games_final.sort.reverse
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end
