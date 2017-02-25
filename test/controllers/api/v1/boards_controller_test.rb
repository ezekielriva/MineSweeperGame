require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  test "GET #index. It returns a list of saved Boards" do
    get api_v1_boards_url
    assert_response :success
  end

  test "POST #create. It creates a new Board" do
    post api_v1_boards_url, params: { board: { size_x: 2, size_y: 2 } }
    assert Board.where(size_x: 2, size_y: 2).exists?
    assert_response :success
  end

  test "POST #create. It returns errors on a wrong create" do
    post api_v1_boards_url, params: { board: { size_x: 1, size_y: 1 } }
    assert !Board.exists?, "The Board exists"
    assert_response :unprocessable_entity
  end

end
