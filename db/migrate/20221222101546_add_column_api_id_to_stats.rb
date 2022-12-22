class AddColumnApiIdToStats < ActiveRecord::Migration[6.1]
  def change
    add_column :stats, :api_id, :integer
  end
end
