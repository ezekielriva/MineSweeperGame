class Square < ApplicationRecord
  belongs_to :board

  def to_mine!
    update(type: 'MineSquare')
  end

  def mine?
    self.type == 'MineSquare'
  end
end
