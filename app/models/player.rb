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
      dreb: average_stat(stats, player, 'dreb'),
      fg_pct: average_stat(stats, player, 'fg_pct'),
      fg3_pct: average_stat(stats, player, 'fg3_pct'),
      ft_pct: average_stat(stats, player, 'ft_pct')
    }
  end

  private

  def average_stat(stats, player, param)
    (stats.inject(0) { |sum, stat| sum.zero? ? (sum + stat.public_send(param)) : (sum + stat.public_send(param) + 0.0) } / player.stats.length).round(1)
  end
end
