class Game < ApplicationRecord
  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :visitor_team, class_name: 'Team', foreign_key: 'visitor_team_id'
  has_many :stats, dependent: :destroy

  def win?(game, team)
    if (game.home_team_id == team.id && game.home_team_score > game.visitor_team_score) ||
       (game.visitor_team_id == team.id && game.home_team_score < game.visitor_team_score)
      true
    end
  end
end
