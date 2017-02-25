module Api
  module V1
    class BaseController < ::ApplicationController
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

      protected

      def unprocessable_entity(exception)
        render json: exception.record.errors, status: :unprocessable_entity
      end
    end
  end
end
