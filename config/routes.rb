Rails.application.routes.draw do
  devise_for :users

  resources :events, except: :index
  resources :comments, except: :index
  resources :filters
  root 'app#index'

  get 'app/index'

  mount ActionCable.server => '/cable'
end
