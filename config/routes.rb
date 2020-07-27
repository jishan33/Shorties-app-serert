Rails.application.routes.draw do
  
  resources :notes

  resources :cohorts

  resources :categories, only: [:index, :create, :update]

  resources :users, only: [:update, :destroy]
  
  post "/notes/shared_note", to: "notes#shared"
  post "/login", to: "user_token#create"
  get "/status", to: "status#index"
  get "/status/user", to: "status#user"
  get "/cohorts/:id/cohorts_students", to: "cohorts#cohorts_students"
  post "/sign-up", to: "users#create"
  root to: "notes#index"
  get "/users", to: "users#index"
  delete "/cohorts/:id/users/:user_id", to: "cohorts#remove_student"
end
