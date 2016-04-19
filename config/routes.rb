Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, except: [:new]
  get 'register' => 'users#new', as: :register

  get 'login' => 'user_sessions#new', as: :login
  post 'login' => 'user_sessions#create'
  get 'logout' => 'user_sessions#edit', as: :logout
  post 'logout' => 'user_sessions#destroy'
end
