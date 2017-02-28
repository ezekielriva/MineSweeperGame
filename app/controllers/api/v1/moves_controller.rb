module Api
  module V1
     class MovesController < BaseController
      before_action :set_board
      before_action :set_move, only: [:show, :update, :destroy]

      # GET /moves
      def index
        @moves = @board.moves.all
        render json: @moves
      end

      # POST /moves
      def create
        move = @board.moves.create(move_params)
        @board.apply_move(move)
        render json: @board, status: :created, location: @move
      end

      private
        def set_move
          @move = @board.moves.find(params[:id])
        end

        def move_params
          params.require(:move).permit(:x, :y, :board_id)
        end

        def set_board
          @board = current_user.boards.find(params[:board_id])
        end
    end
  end
end
