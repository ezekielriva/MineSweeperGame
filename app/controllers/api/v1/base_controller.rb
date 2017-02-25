module Api
  module V1
    class BaseController < ::ApplicationController
      rescue_from ActiveRecord::RecordInvalid,
                  ActiveRecord::RecordNotSaved, with: :unprocessable_entity

      protected

      def unprocessable_entity(exception)
        render json: exception, status: :unprocessable_entity
      end
    end
  end
end
