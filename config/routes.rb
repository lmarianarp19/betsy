Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#root'

  resources :merchants, only: [:show]

  resources :products

  resources :categories, only:[:index, :new, :create]

  resources :billinginfos, only: [:index, :new, :create, :show] # Check if we need index and show

  resources :orders, only: [:show, :create, :update]

  resources :reviews, only: [:new, :create, :index, :show]

  resources :sessions, only: [:login_form, :login, :logout]
end
