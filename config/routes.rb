Rails.application.routes.draw do
  root "static_pages#home"

  get "/contact", to: "static_pages#contact"
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"

  post "/login", to: "sessions#create"
  post "/signup", to: "users#create"

  delete "/logout", to: "sessions#destroy"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show delete)
  resources :microposts, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)
end
