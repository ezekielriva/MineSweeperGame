class CreateSquares < ActiveRecord::Migration[5.0]
  def change
    create_table :squares do |t|
      t.integer :x
      t.integer :y
      t.string :type
      t.boolean :opened, default: false
      t.integer :near_mines, default: 0
      t.belongs_to :board

      t.timestamps
    end
  end
end
