Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :rules
  get 'home/index'
  resources :players, only: [:index, :show] do
    get 'pitchers', on: :collection
    get 'batters', on: :collection
    get '/position/:position', to: 'players#by_position', on: :collection
  end
  resources :teams, only: [:index, :show, :edit]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
