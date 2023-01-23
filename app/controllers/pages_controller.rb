class PagesController < ApplicationController
  def home
    @players = Player.all
    @stats = Stat.all.select { |stat| stat.game.date == '2023-01-18' && stat.min.positive? }
    # (Date.today - 1).strftime('%Y-%m-%d')
  end

  def versus
    @players = []
    @search_player = params['search']

    return unless @search_player_one.present?

    @player_one = @search_player['player_one']
    @player_two = @search_player['player_two']
    @players.push(Player.find_by(last_name: @player_one), Player.find_by(last_name: @player_two))
  end

  def favorite
    @players = []
  end
end
