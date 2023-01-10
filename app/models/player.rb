class Player < ApplicationRecord
  belongs_to :team
  has_many :stats

  validates_uniqueness_of :api_id

  def average(stats, player)
    {
      min: average_stat(stats, player, 'min', 10),
      pts: average_stat(stats, player, 'pts', 10),
      reb: average_stat(stats, player, 'reb', 10),
      ast: average_stat(stats, player, 'ast', 10),
      blk: average_stat(stats, player, 'blk', 10),
      stl: average_stat(stats, player, 'stl', 10),
      turnover: average_stat(stats, player, 'turnover', 10),
      fg3_made: average_stat(stats, player, 'fg3_made', 10),
      dreb: average_stat(stats, player, 'dreb', 10),
      fg_pct: average_stat(stats, player, 'fg_pct', 10),
      fg3_pct: average_stat(stats, player, 'fg3_pct', 10),
      ft_pct: average_stat(stats, player, 'ft_pct', 10),
      games_played: games_played(player, 10),
      rating: average_stat(stats, player, 'rating', 10),
      rating_five_games: average_stat(stats, player, 'rating', 5)
    }
  end

  def today_outperform(stat)
    (stat.rating - stat.player.average(stat.player.stats, stat.player)[:rating]).round(0)
  end

  private

  def average_stat(stats, player, param, games_number)
    if games_played(player, games_number) != 0
      (stats.reverse.first(games_number).inject(0) { |sum, stat| sum.zero? ? (sum + stat.public_send(param)) : (sum + stat.public_send(param) + 0.0) } / games_played(player, games_number)).round(1)
    else
      0
    end
  end

  def games_played(player, games_number)
    player.stats.reverse.first(games_number).reject { |stat| stat.min.zero? }.length
  end
end
