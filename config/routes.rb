Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'status', to: 'status#show'

      resources :boards, only: [:index, :create] do
        resources :moves, only: [:index, :create]
      end
      post 'registrations', to: 'registrations#create'
    end
  end
end
