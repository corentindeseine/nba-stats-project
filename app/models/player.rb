class Player < ApplicationRecord
  belongs_to :team
  has_many :stats

  validates_uniqueness_of :api_id

  def full_name
    "#{first_name} #{last_name}"
  end

  def average(games_count = 10)
    {
      min: average_stat('min', games_count),
      pts: average_stat('pts', games_count),
      reb: average_stat('reb', games_count),
      ast: average_stat('ast', games_count),
      blk: average_stat('blk', games_count),
      stl: average_stat('stl', games_count),
      turnover: average_stat('turnover', games_count),
      fg3_made: average_stat('fg3_made', games_count),
      dreb: average_stat('dreb', games_count),
      fg_pct: average_stat('fg_pct', games_count),
      fg3_pct: average_stat('fg3_pct', games_count),
      ft_pct: average_stat('ft_pct', games_count),
      games_played: games_played(games_count),
      rating: average_stat('rating', games_count),
      rating_five_games: average_stat('rating', 5)
    }
  end

  # def today_outperform(stat)
  #   (stat.rating - average(10)[:rating]).round(0)
  # end

  private

  def average_stat(param, games_count)
    if games_played(games_count) != 0
      (stats.reverse.first(games_count).inject(0) { |sum, stat| sum.zero? ? (sum + stat.public_send(param)) : (sum + stat.public_send(param) + 0.0) } / games_played(games_count)).round(1)
    else
      0
    end
  end

  def games_played(games_count)
    stats.reverse.first(games_count).reject { |stat| stat.min.zero? }.length
  end
end
