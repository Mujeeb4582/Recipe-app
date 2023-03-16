Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  root 'public_recipes#index'
  resources :users do
    resources :recipes, expect: %i[update, edit] do
      get '/general_shopping_list', to: 'shopping_list#index', as: 'general_shopping_list'
      resources :recipe_foods, only: [:new, :create, :destroy, :update, :edit]
    end
    resources :foods, only: [:index, :show, :new, :create, :destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  put '/recipes/:id/toggle_privacy', to: 'recipes#toggle_privacy', as: 'toggle_recipe_privacy'

  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
end
