module Api
  module V1
    class BaseController < ::ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods

      before_action :authenticate!
      rescue_from ActiveRecord::RecordInvalid,
                  ActiveRecord::RecordNotSaved, with: :unprocessable_entity

      protected

      def unprocessable_entity(exception)
        render json: exception, status: :unprocessable_entity
      end

      def authenticate!
        authenticate_or_request_with_http_token do |token, options|
          @token = token
          ApiKey.exists?(access_token: token)
        end unless does_not_need_auth
      end

      def current_user
        @current_user ||= User.find_by_token(@token)
      end

      def does_not_need_auth
        false
      end
    end
  end
end
