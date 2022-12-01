class AddTurnoverColumnToStats < ActiveRecord::Migration[6.1]
  def change
    add_column :stats, :turnover, :integer
  end
end
