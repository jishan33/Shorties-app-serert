Rails.application.routes.draw do
  
  resources :notes
  post "/login", to: "user_token#create"
  get "/status", to: "status#index"
  get "/status/user", to: "status#user"
  post "/sign-up", to: "users#create"
  root to: "notes#index"
end
