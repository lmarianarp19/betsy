class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # TODO: Method for flashes are here
  # TODO: Method to sign in merchant id to @merchant_id = session[:merchant_id]
  # TODO: Method to sign in for order_id in the @current_order_id = session[:current_order_id]??
  # @current_order_id.order_items --> Checks number of order_items in the cart

  before_action :find_merchant

  helper :all

# Need to to make method available to controllers and views
  helper_method :current_order
  helper_method :restrict_merchant
# formats a number into a currency string
  # helper_method :number_to_currency

# helper method to see if there is a session that is holding the order_id, if not, it will create it

  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  # def currency
  #   self.number_to_currency
  # end

  protected
  def save_and_flash(model)
    result = model.save
    if result
      flash[:status] = :success
      flash[:message] = "Successfully saved #{model.class} #{model.id}"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to save #{model.class}"
      flash.now[:details] = model.errors.messages
    end

    return result
  end

  def restrict_merchant(expected_merchant_id)
    @merchant = Merchant.find_by(id: expected_merchant_id)
    #binding.pry
    if @login_merchant.id == @merchant.id
      unless @merchant
        head :not_found
      end
    else
      flash[:status] = :failure
      flash[:message] = "You must be authorized to do that"
      redirect_to root_path
    end
  end


  private
  def find_merchant
    if session[:merchant_id]
      @login_merchant = Merchant.find_by(id: session[:merchant_id])
    end
  end

end
