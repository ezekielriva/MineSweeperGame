module Api
  module V1
    class BoardsController < BaseController
      swagger_controller :boards, 'Board'

      swagger_api :index do
        summary 'List all current user boards'
        param :header, 'Authentication', :string, :required, 'Authentication token'
        response :ok, 'Success'
        response :unauthorized
      end
      def index
        render json: current_user.boards.all
      end

      swagger_api :create do
        summary 'Creates a board'
        param :header, 'Authentication', :string, :required, 'Authentication token'
        param :form, 'board[size_x]', :integer, :required, 'Board Size X'
        param :form, 'board[size_y]', :integer, :required, 'Board Size Y'
        param :form, 'board[no_mines]', :integer, :required, 'Number of Mines'
        response :ok, 'Success', :Square
        response :unauthorized
      end
      def create
        Board.transaction do
          @board = current_user.boards.create(board_params)
          @board.generate_squares
          @board.drop_mines
          @board.fill_numbers
          render json: @board.as_json(includes: :squares)
        end
      end

      private

      def board_params
        params.require(:board).permit(:size_x, :size_y, :no_mines)
      end

      swagger_model :Board do
        description "A Board object."
        property :id, :integer, :required
        property :size_x, :integer, :required
        property :size_y, :integer, :required
        property :no_mines, :integer, :required
        property :squares, :array, :required, item: :Square
      end

      swagger_model :Square do
        description "A Square in a Board"
        property :id, :integer, :required
        property :type, :string, :required
        property :opened, :boolean, :required, 'Was it opened?'
        property :near_mines, :integer, :required, 'Mines near to this square'
        property :board_id, :integer, :required
      end
    end
  end
end
