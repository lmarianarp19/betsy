class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_merchant

  helper :all

  # Need to to make method available to controllers and views
  helper_method :current_order
  helper_method :restrict_merchant
  # formats a number into a currency string
  # helper_method :number_to_currency

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

  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

private

  def find_merchant
    if session[:merchant_id]
      @login_merchant = Merchant.find_by(id: session[:merchant_id])
    end
  end


  def restrict_merchant(expected_merchant_id)
    @merchant = Merchant.find_by(id: expected_merchant_id)

    if @login_merchant.id == @merchant.id
      unless @merchant
        head :not_found
      end
    else
      flash[:status] = :failure
      flash[:message] = "You must be authorized to do that"
      #redirect_to root_path
      redirect_back fallback_location: root_path
    end
  end

end
