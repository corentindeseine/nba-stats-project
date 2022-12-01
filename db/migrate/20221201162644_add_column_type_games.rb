class AddColumnTypeGames < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :api_id, :integer
    add_column :games, :api_id, :integer
  end
end
