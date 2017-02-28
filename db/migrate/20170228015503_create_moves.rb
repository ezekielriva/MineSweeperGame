class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.integer :x
      t.integer :y
      t.belongs_to :board, foreign_key: true
      t.integer :action

      t.timestamps
    end
  end
end
