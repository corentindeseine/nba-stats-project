class AddApiIdColumnToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :api_id, :string
  end
end
