module Api
  module V1
    class BoardsController < BaseController
      def index
        render json: Board.all
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
    end
  end
end
