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
end
