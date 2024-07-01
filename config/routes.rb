require 'sidekiq/web'

Rails.application.routes.draw do

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get '/cart', to: 'carts#index'
    post '/cart', to: 'carts#create'
    delete '/cart/delete_all', to: 'carts#delete_all'
    delete '/cart/:id', to: 'carts#destroy', as: 'delete_cart_items'
    patch	'/cart/:id', to:	'carts#update', as: 'edite_cart_items'

    resources :orders, only: [:new, :create]
    resources :games, only: [:index, :show]
    resources :users, only: [:show]
    resources :favorites

    get '/jobs', to: 'jobs#index'
    post '/download_img', to: 'jobs#download_img', as: 'download_img'

    root 'games#index'
  end
end
