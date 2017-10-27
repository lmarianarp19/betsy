Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'main#root'
  get '/', to: 'main#index', as: 'root'

  resources :merchants, only: :show
  get '/merchants/:merchant_id/products', to: 'merchants#products', as: 'merchant_products'

  resources :products, except: :destroy do
    resources :reviews, only: [:new, :create]
  end

  get 'categories/:id/products', to: 'products#index', as: 'products_categories'

  # Add resource not resources because a customer will only have one shopping cart and doesn't create an index route
  resource :cart, only: :show

  # resources :payments, only: [:index, :show]

  resources :orders, only: [:show, :create, :update] do
    resources :payments, only: [:index, :new, :create]
  end
  get '/merchants/:merchant_id/orders', to: 'orders#index', as: 'merchant_orders'

  resources :order_items, only: [:create, :update, :destroy]
  patch '/order_items/:id/ship', to: 'order_items#ship', as:'ship_order_item'

  get '/auth/github', as: 'github'
  get '/auth/:provider/callback', to: 'sessions#login', as: "auth_callback"
  get '/logout', to: 'sessions#logout', as: 'logout'

end
