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
        squares.create(x: i, y: j)
      end
    end
  end

  def drop_mines
    no_mines.times do
      x = rand(size_x)
      y = rand(size_y)

      squares.find_by(x: x, y: y).to_mine!
    end
  end

  def fill_numbers
    mine_squares.each do |mine_square|
      adjacents_to(mine_square).each do |square|
        square.near_mines = adjacents_to(square).merge(mine_squares).count
        square.save
      end
    end
  end

  def adjacents_to(center_square)
    squares.where(x: (center_square.x - 1..center_square.x+1),
                  y: (center_square.y-1..center_square.y+1))
           .where.not(id: center_square)
  end
end
