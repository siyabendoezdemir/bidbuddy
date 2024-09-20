Rails.application.routes.draw do
  get "dashboards/show"
  root "dashboards#show"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  resource :dashboard, only: [ :show ]
  resources :auctions, only: [ :index, :show, :new, :create ]
  resources :items, only: [ :index, :new, :create ]
  get "admin", to: "admin#index"

  resources :items
  resources :auctions do
    resources :bids, only: [ :create ]
  end
  get "/admin", to: "admin#index"
  get "/admin/auctions/:id/review", to: "admin#review_auction", as: "review_auction_admin"
  post "/admin/auctions/:id/process", to: "admin#process_auction", as: "process_auction_admin"
end
