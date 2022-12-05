class AddFloatToFieldGoalStats < ActiveRecord::Migration[6.1]
  def change
    remove_column :stats, :min, :string
    remove_column :stats, :fg_pct, :integer
    remove_column :stats, :fg3_pct, :integer
    remove_column :stats, :ft_pct, :integer
  end
end
