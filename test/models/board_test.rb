require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  test 'its size should be greater than 1x1' do
    board = Board.new(size_x: 1, size_y: 1)
    assert !board.valid?, "The board is valid."
  end
end
