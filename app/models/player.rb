class Player < ApplicationRecord
  belongs_to :team
  has_many :stats

  validates_uniqueness_of :api_id

  def average(stats, player)

    {
      min: stats.inject(0) { |sum, stat| sum + stat.min.to_i } / player.stats.length,
      pts: (stats.inject(0) { |sum, stat| sum + stat.pts + 0.0 } / player.stats.length).round(1),
      reb: (stats.inject(0) { |sum, stat| sum + stat.reb + 0.0 } / player.stats.length).round(1),
      ast: (stats.inject(0) { |sum, stat| sum + stat.ast + 0.0 } / player.stats.length).round(1),
      blk: (stats.inject(0) { |sum, stat| sum + stat.blk + 0.0 } / player.stats.length).round(1),
      stl: (stats.inject(0) { |sum, stat| sum + stat.stl + 0.0 } / player.stats.length).round(1),
      turnover: (stats.inject(0) { |sum, stat| sum + stat.turnover + 0.0 } / player.stats.length).round(1),
      dreb: (stats.inject(0) { |sum, stat| sum + stat.dreb + 0.0 } / player.stats.length).round(1),
      fg_pct: stats.inject(0) { |sum, stat| sum + stat.fg_pct } / player.stats.length,
      fg3_pct: stats.inject(0) { |sum, stat| sum + stat.fg3_pct } / player.stats.length,
      ft_pct: stats.inject(0) { |sum, stat| sum + stat.ft_pct } / player.stats.length
    }
  end

end
