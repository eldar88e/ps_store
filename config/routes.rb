Rails.application.routes.draw do

  get '/cart', to: 'carts#index'
  post '/cart', to: 'carts#create'
  delete '/cart/delete_all', to: 'carts#delete_all'
  delete '/cart/:id', to: 'carts#destroy', as: 'delete_cart_items'
  patch	'/cart/:id', to:	'carts#update', as: 'edite_cart_items'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :games, only: [:index, :show]
  root "games#index"
end
