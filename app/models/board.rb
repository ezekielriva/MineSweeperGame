class Board < ApplicationRecord
  has_many :squares

  validates :size_x, numericality: {
    greater_than: 1
  }
  validates :size_y, numericality: {
    greater_than: 1
  }

  def generate_squares
    size_x.times do |i|
      size_y.times do |j|
        squares.build(x: i, y: j)
      end
    end
  end
end
