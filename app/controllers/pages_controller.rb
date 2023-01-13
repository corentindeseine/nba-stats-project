class PagesController < ApplicationController
  def home
    @players = Player.all
    @stats = Stat.all.select { |stat| stat.game.date == (Date.today - 10).strftime('%Y-%m-%d') && stat.min.positive? }
  end

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
