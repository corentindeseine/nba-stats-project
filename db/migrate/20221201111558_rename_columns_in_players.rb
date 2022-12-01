class RenameColumnsInPlayers < ActiveRecord::Migration[6.1]
  def change
    rename_column :players, :name, :first_name
    rename_column :players, :team, :position
  end
end
