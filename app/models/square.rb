class Square < ApplicationRecord
  belongs_to :board

  def in_position(pos_x, pos_y)
    x == pos_x && y == pos_y
  end

  def to_mine
    self.type = 'MineSquare'
  end
end
