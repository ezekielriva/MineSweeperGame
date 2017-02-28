class Square < ApplicationRecord
  belongs_to :board

  scope :unrevealed, ->() { where(opened: false) }
  scope :revealed, ->() { where(opened: true) }
  scope :no_mines, ->() { where(type: nil) }

  def self.reveal(move)
    square = find_by(x: move.x, y: move.y)
    if move.reveal?
      square.update(opened: true)
    elsif move.flag?
      square.update(type: 'FlagSquare')
    end
  end

  def to_mine!
    update(type: 'MineSquare')
  end

  def mine?
    self.type == 'MineSquare'
  end
end
