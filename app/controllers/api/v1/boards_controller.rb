module Api
  module V1
    class BoardsController < BaseController
      def index
        render json: Board.all
      end

      def create
        @board = Board.new(board_params)
        @board.save!
        render json: @board
      end

      private

      def board_params
        params.require(:board).permit(:size_x, :size_y)
      end
    end
  end
end
