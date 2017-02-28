module Api
  module V1
     class MovesController < BaseController
      before_action :set_board
      before_action :set_move, only: [:show, :update, :destroy]

      swagger_controller :moves, 'Moves'
      swagger_api :index do
        summary 'List all boards moves'
        param :header, 'Authentication', :string, :required, 'Authentication token'
        response :ok, 'Success'
        response :unauthorized
      end
      def index
        @moves = @board.moves.all
        render json: @moves
      end

      swagger_api :create do
        summary 'Creates a move & check game status'
        param :header, 'Authentication', :string, :required, 'Authentication token'
        param :form, 'move[x]', :integer, :required, 'Move X'
        param :form, 'move[y]', :integer, :required, 'Move Y'
        param :form, 'move[board_id]', :integer, :required, 'Board Id'
        response :ok, 'Success', :Board
        response :unauthorized
      end
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
