Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]

  as :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
    get '/login', to: 'sessions#new', as: :login
  end

  authenticated :user do
    root 'recipes#index', as: :authenticated_root
  end

  devise_scope :user do
    unauthenticated :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :shoppinglists
  resources :recipes
  resources :recipe_foods
  resources :foods
  resources :users, constraints: { id: /(?!sign_out).*/ }

  get "up" => "rails/health#show", as: :rails_health_check

  root "foods#index"
  get '/public_recipe', to: 'recipes#public'
  get '/general_shopping_list', to: 'shoppinglists#index'

end
