Rails.application.routes.draw do
  resources :rules
  get 'home/index'
  resources :players, only: [:index, :show]
  resources :teams, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
