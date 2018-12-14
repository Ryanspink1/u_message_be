Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users,       only: [:show, :create, :index, :update]
      resources :friendships, only: [:show, :index, :create, :update, :destroy]
      resources :messages, only: [:create]
      resources :conversations do
        get '/messages/', to: 'conversations/messages#index'
        collection do
          get 'find_or_create'
        end
      end
      post 'user_token' => 'user_token#create'
      mount ActionCable.server => '/cable'
    end
  end
end
