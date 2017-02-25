Rails.application.routes.draw do
  resources :squares
  namespace :api do
    namespace :v1 do
      get 'status', to: 'status#show'

      resources :boards, only: [:index, :create]
    end
  end
end
