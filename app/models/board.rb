class Board < ApplicationRecord
  has_many :squares
  has_many :mine_squares

  validates :size_x, numericality: {
    greater_than: 1
  }, presence: true
  validates :size_y, numericality: {
    greater_than: 1
  }, presence: true
  validates :no_mines, numericality: {
    less_than: ->(board) { board.size_x * board.size_y }
  }, presence: true

  def generate_squares
    size_x.times do |i|
      size_y.times do |j|
        squares.build(x: i, y: j)
      end
    end
  end

  def drop_mines
    no_mines.times do
      x = rand(size_x)
      y = rand(size_y)

      squares.find { |square| square.in_position(x,y) }.to_mine
    end
  end
end
