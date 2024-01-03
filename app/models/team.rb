class Team < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :home_games, class_name: 'Game', foreign_key: 'home_team_id'
  has_many :visitor_games, class_name: 'Game', foreign_key: 'visitor_team_id'
  has_one_attached :logo

  def past_games
    (home_games + visitor_games).sort_by { |game| game[:date] }.reverse.reject { |game| game.home_team_score.zero? }
  end

  def sort_players(stat)
    players.sort_by { |player| player.average[stat] }.reverse
  end

  def all_games
    return home_games + visitor_games
  end

  def win_lose_counter
    win_lose_counter = {win: 0, lose: 0, win_rate: 0.0}
    all_games.each {|game| game.win?(game,self) ? win_lose_counter[:win] += 1 : win_lose_counter[:lose] += 1 }
    win_rate = win_lose_counter[:win] / (win_lose_counter[:win] + win_lose_counter[:lose]).to_f
    win_rate_formated = sprintf("%.3f", win_rate)
    win_lose_counter[:win_rate] = "." + win_rate_formated.to_s.split('.')[1]

    return win_lose_counter
  end

  def self.split_by_conferences
    teams = Team.all
    east_teams = teams.select { |team| team.conference == 'East' }
    west_teams = teams.select { |team| team.conference == 'West' }

    { eastern_conference: east_teams, western_conference: west_teams }
  end
end
