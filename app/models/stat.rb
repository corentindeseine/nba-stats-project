class Stat < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates_uniqueness_of :api_id
end
