class PaymentsController < ApplicationController

  def new # Show the form for billing info
    @payment = Payment.new
  end

  #TODO: Afters submitting, also needs to update order status and save order to the db

  def create
    @payment = Payment.new(payment_params)

    if @payment.save

      #TODO: Cannot save the order id as a session until the order is created!
      order =  Order.find_by(id: params[:order_id])
      order.status = "paid"
      @payment.order_id = order.id
      flash[:status] = :success
      flash[:message] = "success payment"
      redirect_to root_path
      #TODO Page with the order 
      #redirect_to order_path(@billing_info.order.id)
    else
      flash[:status] = :failure
      flash[:message] = "Whoops! Something was wrong when placing your order!"
      render :new, status: :bad_request
    end
  end


  private

  def payment_params
    params.require(:payment).permit(:email, :mailing_address, :cc_name, :cc_expiration, :cc_number, :cc_ccv, :billing_zip, :order_id)
  end

end
