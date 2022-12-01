class Player < ApplicationRecord
  belongs_to :team
  validates_uniqueness_of :api_id
end
