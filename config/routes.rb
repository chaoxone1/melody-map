Rails.application.routes.draw do
  devise_for :users
  root to: "events#index"

  # Health status route
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

  resources :followers do
    member do
      post 'follow', to: 'creators#follow'
    end
  end

  resources :users, only: [:show]
  resources :bookmarks, only: [:index, :create, :destroy]
  resources :followers, only: [:index, :create, :destroy]

  get "trendsetters", to: "pages#trendsetters_index"
  get "trendsetters/:id", to: "pages#trendsetters_show", as: :trendsetter
  get "abouts", to: "pages#abouts_us"
  get 'myspaces', to: 'pages#myspaces'
  get 'myspace', to: 'pages#myspace'
  get 'my_created_events', to: 'pages#created_events'
  post 'followers/:id', to: 'followers#create'
  delete 'followers/:id', to: 'followers#destroy'
  get '/404', to: 'errors#not_found'
end
