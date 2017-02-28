require 'test_helper'

class MovesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board = user.boards.create(size_x: 2, size_y: 2, no_mines: 1)
    @board.generate_squares
    @board.drop_mines
    @board.fill_numbers
    @move  = moves(:one)
  end

  test "should get index" do
    get api_v1_board_moves_url(@board),
      as: :json,
      headers: auth_headers
    assert_response :success
  end

  test "should create move" do
    assert_difference('Move.count') do
      post api_v1_board_moves_url(@board),
        params: { move: { x: @move.x, y: @move.y }},
        as: :json,
        headers: auth_headers
    end

    assert_response :success
  end
end
