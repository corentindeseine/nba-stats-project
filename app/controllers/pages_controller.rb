class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def home
    teams = Team.all.split_by_conferences
    @western_teams = teams[:western_conference].sort_by { |team| team.win_lose_counter[:win_rate] }.reverse
    @eastern_teams = teams[:eastern_conference].sort_by { |team| team.win_lose_counter[:win_rate] }.reverse

  end

  def versus
    @list_players = Player.all.order(:last_name).reject { |player| player.average(player.stats, player)[:min].zero? }
    @list_active_players = @list_players.map { |p| [p.full_name, p.id] }
    @players = []
    @search_player = params['search']

    return unless @search_player.present?

    player_one_id = @search_player['player_one_id']
    player_two_id = @search_player['player_two_id']
    @players.push(Player.find(player_one_id.to_i), Player.find(player_two_id.to_i))
    # flash[:error] = "Please select two players"
    # render 'pages/versus'
  end

  def favorite
    @players = []
  end
end
