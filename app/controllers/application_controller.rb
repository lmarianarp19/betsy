class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # TODO: Method for flashes are here
  # TODO: Method to sign in merchant id to @merchant_id = session[:merchant_id]
  # TODO: Method to sign in for order_id in the @current_order_id = session[:current_order_id]??
  # @current_order_id.order_items --> Checks number of order_items in the cart
end
