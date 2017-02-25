class AddNoMinesToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :no_mines, :integer
  end
end
