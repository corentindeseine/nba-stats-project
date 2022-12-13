class AddRatingToStats < ActiveRecord::Migration[6.1]
  def change
    add_column :stats, :rating, :integer
  end
end
