Rails.application.routes.draw do
  devise_for :users
  # resources :users
  root 'app#index'

  get 'app/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end