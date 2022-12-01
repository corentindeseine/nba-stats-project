class AddUniquenessToPlayers < ActiveRecord::Migration[6.1]
  def change
    change_column :players, :api_id, :string, unique: true
  end
end
