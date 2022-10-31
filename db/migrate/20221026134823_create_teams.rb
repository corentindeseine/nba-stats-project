class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :abbreviation
      t.string :conference
      t.integer :api_id

      t.timestamps
    end
  end
end
