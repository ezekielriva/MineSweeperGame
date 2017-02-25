module Api
  module V1
    class BoardsController < BaseController
      swagger_controller :boards, 'Board'

      swagger_api :index do
        summary 'List all boards'
        response :ok, 'Success'
      end
      def index
        render json: Board.all
      end

      swagger_api :create do
        summary 'Creates a board'
        param :form, 'board[size_x]', :integer, :required, 'Board Size X'
        param :form, 'board[size_y]', :integer, :required, 'Board Size Y'
        param :form, 'board[no_mines]', :integer, :required, 'Number of Mines'
        response :ok, 'Success', :Board
      end
      def create
        Board.transaction do
          @board = Board.create(board_params)
          @board.generate_squares
          @board.drop_mines
          @board.fill_numbers
          render json: @board
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
      end
    end
  end
end
