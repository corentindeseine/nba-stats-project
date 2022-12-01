class CreateStats < ActiveRecord::Migration[6.1]
  def change
    create_table :stats do |t|
      t.string :min
      t.integer :pts
      t.integer :reb
      t.integer :ast
      t.integer :blk
      t.integer :stl
      t.integer :dreb
      t.integer :fg3_made
      t.integer :fg_pct
      t.integer :fg3_pct
      t.integer :ft_pct
      t.references :game, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
