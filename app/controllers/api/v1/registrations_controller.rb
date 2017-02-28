module Api
  module V1
    class RegistrationsController < BaseController
      swagger_controller :users, 'Users'
      swagger_api :create do
        summary 'Creates a move & check game status'
        param :form, 'users[username]', :string, :required, 'User username'
        param :form, 'users[email]', :string, :optional, 'User email'
        param :form, 'users[first_name]', :string, :optional, 'Users first name'
        param :form, 'users[last_name]', :string, :optional, 'Users last name'
        response :ok, 'Success', :User
      end
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

      swagger_model :User do
        description "A User object."
        property :id, :integer, :required
        property :username, :string, :required
        property :email, :string, :optional
        property :first_name, :string, :optional
        property :last_name, :string, :optional
        property :api_key, :ApiKey, :required
      end

      swagger_model :ApiKey do
        description "The User ApiKey object."
        property :id, :integer, :required
        property :user_id, :integer, :required
        property :access_token, :string, :required
      end
    end
  end
end
