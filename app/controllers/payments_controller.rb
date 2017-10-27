class PaymentsController < ApplicationController

  def new # Show the form for billing info
    order =  Order.find_by(id: params[:order_id])
    if order
      @payment = Payment.new
      @payment.order_id = params[:order_id]
    else
      head :not_found
    end
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.order_id = params[:order_id] #TODO: May have to change this to @order instead of using the session


    if @payment.save
      order =  Order.find_by(id: params[:order_id])

      order.products.each do |item|
        order.order_items.each do |order_item|
          item.inventory -= order_item.quantity
          item.save
        end
      end

      order.status = "paid"
      order.save

      session[:order_id] = nil

      flash[:status] = :success
      flash[:message] = "success payment"
      redirect_to order_path(@payment.order_id)

    else
      flash[:status] = :failure
      flash[:message] = "Whoops! Something was wrong when placing your order!"
      flash[:details] = @payment.errors.messages
      render :new, status: :bad_request
    end
  end


  def show
    if @login_merchant
      @payment = Payment.find_by(id: params[:id])
      if @login_merchant.orders.ids.include? @payment.order_id
        return @payment
      end
    end
      flash_unathorized
      redirect_to root_path
  end

  private

  def payment_params
    params.require(:payment).permit(:name, :email, :mailing_address, :cc_name, :cc_expiration, :cc_number, :cc_ccv, :billing_zip)
  end
end
