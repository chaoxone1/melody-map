Rails.application.routes.draw do
  devise_for :users
  root to: "events#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :events do
    member do
      post 'bookmark', to: 'events#bookmark'
      post 'favorite', to: 'events#favorite'
      delete 'unfavorite', to: 'events#unfavorite'
    end
  end

  resources :creators do
    member do
      post 'follow', to: 'creators#follow'
    end
  end

  resources :events
  resources :users
  resources :bookmarks
  resources :followers
  get "trendsetters", to: "pages#trendsetters_index"
  # config/routes.rb
  get 'myspaces', to: 'pages#myspaces'
  get 'followers', to: 'followers#index'
  get 'bookmarks', to: 'bookmarks#index'
  get 'events', to: 'events#index'
  get 'trendsetters', to: 'pages#trendsetters_index'
  get 'myspace', to: 'pages#myspace'

  resources :followers, only: [:create, :destroy]
  resources :users, only: [:show]
end
