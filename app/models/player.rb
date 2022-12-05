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
      fg_pct: average_stat_pct(stats, player, 'fg_pct'),
      fg3_pct: average_stat_pct(stats, player, 'fg3_pct'),
      ft_pct: average_stat_pct(stats, player, 'ft_pct')
    }
  end

  private

  def average_stat(stats, player, param)
    (stats.reverse.first(10).inject(0) { |sum, stat| sum.zero? ? (sum + stat.public_send(param)) : (sum + stat.public_send(param) + 0.0) } / 10).round(1)
  end

  def average_stat_pct(stats, player, param)
    (stats.reverse.first(10).inject(0) { |sum, stat| sum + stat.public_send(param) } / player.stats.reverse.first(10).reject { |stat| stat.min.zero? }.length).round(1)
  end
end
