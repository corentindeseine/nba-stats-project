class Player < ApplicationRecord
  belongs_to :team
  has_many :stats

  validates_uniqueness_of :api_id

  def average(stats, player)
    {
      min: average_stat(stats, player, 'min'),
      pts: average_stat(stats, player, 'pts'),
      reb: average_stat(stats, player, 'reb'),
      ast: average_stat(stats, player, 'ast'),
      blk: average_stat(stats, player, 'blk'),
      stl: average_stat(stats, player, 'stl'),
      turnover: average_stat(stats, player, 'turnover'),
      fg3_made: average_stat(stats, player, 'fg3_made'),
      dreb: average_stat(stats, player, 'dreb'),
      fg_pct: average_stat(stats, player, 'fg_pct'),
      fg3_pct: average_stat(stats, player, 'fg3_pct'),
      ft_pct: average_stat(stats, player, 'ft_pct'),
      games_played: games_played(player),
      rating: average_stat(stats, player, 'rating')
    }
  end

  private

  def average_stat(stats, player, param)
    if games_played(player) != 0
      (stats.reverse.first(10).inject(0) { |sum, stat| sum.zero? ? (sum + stat.public_send(param)) : (sum + stat.public_send(param) + 0.0) } / games_played(player)).round(1)
    else
      0
    end
  end

  def games_played(player)
    player.stats.reverse.first(10).reject { |stat| stat.min.zero? }.length
  end
end
