Rails.application.routes.draw do
  root to: "users#index"

  resources :users

  get 'login' => 'user_sessions#new', as: :login
  post 'login' => 'user_sessions#create'
  get 'logout' => 'user_sessions#edit', as: :logout
  post 'logout' => 'user_sessions#destroy'
end
