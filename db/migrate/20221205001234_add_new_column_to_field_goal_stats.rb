class AddNewColumnToFieldGoalStats < ActiveRecord::Migration[6.1]
  def change
    add_column :stats, :min, :integer
    add_column :stats, :fg_pct, :float
    add_column :stats, :fg3_pct, :float
    add_column :stats, :ft_pct, :float
  end
end
