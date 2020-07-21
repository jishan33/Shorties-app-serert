Rails.application.routes.draw do
  
  resources :notes

  resources :cohorts

  resources :categories, only: [:index, :create, :update]

  resources :users, only: [:update, :destroy]

  get "/notes/:id/show_categories", to: "notes#show_categories"
  
  post "/login", to: "user_token#create"
  get "/status", to: "status#index"
  get "/status/user", to: "status#user"
  post "/sign-up", to: "users#create"
  root to: "user_token#create"
end
