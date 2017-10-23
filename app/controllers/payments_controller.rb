class PaymentsController < ApplicationController

  def new # Show the form for billing info
    order =  Order.find_by(id: params[:order_id])
    if order
      @payment = Payment.new
      @payment.order_id = params[:order_id]
    else
      # render new, status: not_found
      head :not_found
    end
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.order_id = params[:order_id]

    if @payment.save

      #TODO: Cannot save the order id as a session until the order is created!
      order =  Order.find_by(id: params[:order_id])

      #binding.pry

      order.status = "paid"
      order.save
      #@payment.order_id = order.id
      flash[:status] = :success
      flash[:message] = "success payment"
      redirect_to root_path
      #redirect_to order_path(@payment.order_id)
      #TODO redirect to page with the order view
    else
      flash[:status] = :failure
      flash[:message] = "Whoops! Something was wrong when placing your order!"
      render :new, status: :bad_request
      #TODO to put specific messages for errors i.e. Invalid Credit Card number...
    end
  end


  private

  def payment_params
    params.require(:payment).permit(:email, :mailing_address, :cc_name, :cc_expiration, :cc_number, :cc_ccv, :billing_zip)
  end

end
