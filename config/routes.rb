Rails.application.routes.draw do
  resource :session

  resources :rooms, only: [:show, :index], param: :room_id

  resources :subscriptions, only: [:destroy], param: :room_id

  root to: 'rooms#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
