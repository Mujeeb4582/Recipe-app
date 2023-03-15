Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  root 'recipes#index'
  resources :users do
    resources :recipes, expect: %i[update, edit]
    resources :foods, only: [:index, :show, :new, :create, :destroy]
  end

  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
end
