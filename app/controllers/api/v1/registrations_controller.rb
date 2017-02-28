module Api
  module V1
    class RegistrationsController < BaseController
      def create
        @user = User.new(user_params)
        @user.build_api_key
        @user.save!
        render json: @user.as_json(include: :api_key)
      end

      protected

      def does_not_need_auth
        true
      end

      private

      def user_params
        params.require(:users)
              .permit(:email, :username, :first_name, :last_name)
      end
    end
  end
end
