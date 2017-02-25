require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  test "GET #index. It returns a list of saved Boards" do
    get api_v1_boards_url
    assert_response :success
  end

  test "POST #create. It creates a new Board" do
    post api_v1_boards_url, params: { board: { size_x: 2, size_y: 2, no_mines: 1 } }

    board = Board.find_by(size_x: 2, size_y: 2, no_mines: 1)

    assert board
    assert_equal board.squares.count, (board.size_x * board.size_y), "The size does not match"
    assert_equal board.mine_squares.count, board.no_mines, "There is no mines"
    assert_equal board.squares.where(near_mines: 0).count, board.no_mines, "There is no adjacent numbers"
    assert_response :success
  end

  test "POST #create. It returns errors on a wrong create" do
    post api_v1_boards_url, params: { board: { size_x: 1, size_y: 1, no_mines: 1 } }
    assert !Board.exists?, "The Board exists"
    assert_response :unprocessable_entity
  end

end
