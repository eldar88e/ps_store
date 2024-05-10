Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show]

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get '/cart', to: 'carts#index'
    post '/cart', to: 'carts#create'
    delete '/cart/delete_all', to: 'carts#delete_all'
    delete '/cart/:id', to: 'carts#destroy', as: 'delete_cart_items'
    patch	'/cart/:id', to:	'carts#update', as: 'edite_cart_items'

    resources :orders, only: [:new, :create]

    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    resources :games, only: [:index, :show]
    resources :favorites

    root 'games#index'
  end
end
