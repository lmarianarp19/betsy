Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'main#root'
  get '/', to: 'main#index', as: 'root'


  resources :merchants, only: [:show]

  #TODO: POSSIBLE NESTED ROUTES

  # merchant/:id/products

  resources :products do
    resources :reviews, only: [:new, :create, :index, :show]
  end

  resources :categories, only:[:index, :new, :create]

  # TODO: # Check if we need index and show
  resources :payments, only: [:index, :new, :create, :show]

  resources :orders, only: [:show, :create, :update] do
    # get '/cart', to: 'cart#index'
  end

  # resources :reviews, only: [:new, :create, :index, :show]

  resources :sessions, only: [:login, :logout]

  resources :orderitems, only: [:create, :update, :destroy]

  get '/auth/github', as: 'github'
  get '/auth/:provider/callback', to: 'sessions#login'
  post '/logout', to: 'sessions#logout', as: 'logout'


  # get "/users", to: "users#index", as: "users"
  # get "/users/new", to: "users#new", as: "new_user"
  # post "/users", to: "users#create"
  # get "/users/:id", to: "users#show", as: "user"
  # get "/users/:id/edit", to: "users#edit", as: "edit_user"
  # patch "/users/:id", to: "users#update"
  # delete "/users/:id", to: "users#destroy"

end
