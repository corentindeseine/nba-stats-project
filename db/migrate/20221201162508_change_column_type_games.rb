class ChangeColumnTypeGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :players, :api_id, :integer
    remove_column :games, :api_id, :integer
  end
end
