class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.integer :size_x
      t.integer :size_y

      t.timestamps
    end
  end
end
