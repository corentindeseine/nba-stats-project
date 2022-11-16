class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :date
      t.integer :period
      t.integer :home_team_score
      t.integer :visitor_team_score
      t.references :home_team, foreign_key: { to_table: 'teams' }
      t.references :visitor_team, foreign_key: { to_table: 'teams' }

      t.timestamps
    end
  end
end
