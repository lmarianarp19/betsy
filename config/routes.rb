Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'main#root'
  get '/', to: 'main#index', as: 'root'

  resources :merchants, only: [:show]

  get '/merchants/:merchant_id/orders', to: 'orders#index', as: 'merchant_orders'

  #TODO: POSSIBLE NESTED ROUTES
  # merchant/:id/products to show all merchant products?

  resources :products do
    resources :reviews, only: [:new, :create]
    resources :categories, only:[:index]
  end

  get 'categories/:id/products', to: 'products#index', as: 'products_categories'

  #add resource not resources because a customer will only have one shopping cart and doesn't create an index route
  resource :cart, only: [:show, :update]

  # TODO: # Check if we need index and show
  resources :payments, only: [:index, :show]
#, only: [:show, :create, :update]


  resources :orders, only: [:show, :create, :update]

  resources :orders do
#    resources :payments, only: [:new, :create, :index]
    resources :payments, only: [:index, :new, :create]
  end


  # TODO: #product/:id/reviews
  resources :sessions, only: [:login, :logout]

  resources :order_items, only: [:new, :create, :update, :destroy]
  # post 'order_items', to: 'order_items#create', as: 'order_items'

  get '/auth/github', as: 'github'
  get '/auth/:provider/callback', to: 'sessions#login', as: "auth_callback"
  post '/logout', to: 'sessions#logout', as: 'logout'

  patch '/order_items/:id/ship', to: 'order_items#ship', as:'ship_order_item' 

  # get "/users", to: "users#index", as: "users"
  # get "/users/new", to: "users#new", as: "new_user"
  # post "/users", to: "users#create"
  # get "/users/:id", to: "users#show", as: "user"
  # get "/users/:id/edit", to: "users#edit", as: "edit_user"
  # patch "/users/:id", to: "users#update"
  # delete "/users/:id", to: "users#destroy"

end
