class Team < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :home_games, class_name: 'Game', foreign_key: 'home_team_id'
  has_many :visitor_games, class_name: 'Game', foreign_key: 'visitor_team_id'
  has_one_attached :logo

  def past_games(team)
    (team.home_games + team.visitor_games).sort_by { |e| e[:date] }.reverse.reject { |game| game.home_team_score.zero? }
  end

  def sort_players(team, stat)
    team.players.each.sort_by { |player| player.average(player.stats, player)[stat] }.reverse
  end
end
