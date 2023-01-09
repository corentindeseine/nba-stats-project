class PagesController < ApplicationController

  def versus
    @players = []
    @search_player_one = params['search']

    return unless @search_player_one.present?

    @player_one = @search_player_one['player_one']
    @player_two = @search_player_one['player_two']
    @players.push(Player.find_by(last_name: @player_one), Player.find_by(last_name: @player_two))
  end

  def favorite
    @players = []
  end
end
