require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  def setup
    @board = user.boards.create(size_x: 2, size_y: 2, no_mines: 1)
    @board.generate_squares
    @board.drop_mines
    @board.fill_numbers
  end

  test 'its size should be greater than 1x1' do
    board = user.boards.create(size_x: 1, size_y: 1, no_mines: 0)
    assert !board.valid?, "The board is valid."
  end

  test 'its number of mines should be lower than board size' do
    board = user.boards.create(size_x: 2, size_y: 2, no_mines: 5)
    assert !board.valid?, "The board is valid"
  end

  test 'its drop mines into the board' do
    assert @board.mine_squares.length, 1
  end

  test 'its creates the squares' do
    assert_equal @board.squares.uniq.length, 4
  end

  test 'returns adjacents squares to one square' do
    center_square = @board.squares.find_by(x: 1, y: 1)
    assert_equal 3, @board.adjacents_to(center_square).length
  end

  test 'fills the adjacents squares with numbers' do
    assert_equal 3, @board.squares.where(near_mines: 1).count
  end

  test 'checks lose move' do
    assert_raises(Board::LoseException) do
      mine_square = @board.mine_squares.first
      move = @board.moves.create(x: mine_square.x, y: mine_square.y, action: :reveal)
      @board.apply_move(move)
    end
  end

  test 'checks win move' do
    assert_raises(Board::WinException) do
      @board.squares.no_mines.each do |square|
        move = @board.moves.create!(x: square.x, y: square.y, action: :reveal)
        @board.apply_move(move)
      end
    end
  end
end
