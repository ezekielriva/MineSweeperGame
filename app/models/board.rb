class Board < ApplicationRecord
  validates :size_x, numericality: {
    greater_than: 1
  }
  validates :size_y, numericality: {
    greater_than: 1
  }
end
