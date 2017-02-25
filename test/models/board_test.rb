require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  test 'its size should be greater than 1x1' do
    board = Board.create(size_x: 1, size_y: 1, no_mines: 0)
    assert !board.valid?, "The board is valid."
  end

  test 'its number of mines should be lower than board size' do
    board = Board.create(size_x: 2, size_y: 2, no_mines: 5)
    assert !board.valid?, "The board is valid"
  end

  test 'its drop mines into the board' do
    board = Board.create(size_x: 2, size_y: 2, no_mines: 1)
    board.generate_squares
    board.drop_mines

    assert board.mine_squares.length, 1
  end

  test 'its creates the squares' do
    board = Board.create(size_x: 2, size_y: 2, no_mines: 1)
    board.generate_squares

    assert_equal board.squares.length, 4
  end

  test 'returns adjacents squares to one square' do
    board = Board.create(size_x: 2, size_y: 2, no_mines: 1)
    board.generate_squares

    center_square = board.squares.find_by(x: 1, y: 1)
    assert_equal 3, board.adjacents_to(center_square).length
  end

  test 'fills the adjacents squares with numbers' do
    board = Board.create(size_x: 2, size_y: 2, no_mines: 1)
    board.generate_squares
    board.drop_mines
    board.fill_numbers

    assert_equal 3, board.squares.where(near_mines: 1).count
  end
end
