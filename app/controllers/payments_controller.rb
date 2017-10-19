class PaymentsController < ApplicationController

  def new # Show the form for billing info
    @billing_info = Payment.new
  end

  #TODO: Afters submitting, also needs to update order status and save order to the db

  def create
    @billing_info = Payment.new(billing_params)

    if @billing_info.save!

      #TODO: Cannot save the order id as a session until the order is created!

      @current_order_id.billing_id = @billing_info.id

      redirect_to order_path(@billing_info.order.id)
    else
      flash[:status] = :failure
      flash[:message] = "Whoops! Something was wrong when placing your order!"
      render :new, status: :bad_request
    end
  end


  private

  def billing_params
    params.require(:billinginfo).permit(:email, :address, :creditcard, :expiration, :cvv, :zipcode)
  end

end

# Email Address
# Mailing Address
# Name on credit card
# Credit card number
# Credit cart expiration
# Credit Card CVV (security code)
# Billing zip code
