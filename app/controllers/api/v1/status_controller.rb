module Api
  module V1
    class StatusController < BaseController
      swagger_controller :status, 'Status'

      swagger_api :show do
        summary 'Shows the current api status'
        response :ok, 'Success', :Status
      end
      def show
        render json: { status: :ok }
      end

      swagger_model :Status do
        description "A Status object."
        property_list :status, :string, :required, ["ok", "warning", "error"]
      end

      def does_not_need_auth
        true
      end
    end
  end
end
