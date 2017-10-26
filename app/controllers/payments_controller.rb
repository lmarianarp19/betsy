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
      order =  Order.find_by(id: params[:order_id])

      order.products.each do |item|
        order.order_items.each do |order_item|
          item.inventory -= order_item.quantity
          item.save
        end
      end

      order.status = "paid"
      order.save

      session.clear

      flash[:status] = :success
      flash[:message] = "success payment"
      redirect_to order_path(params[:order_id])
      #redirect_to order_path(@payment.order_id)
      #TODO redirect to page with the order view
    else
      flash[:status] = :failure
      flash[:message] = "Whoops! Something was wrong when placing your order!"
      flash[:cc_errors] = @payment.errors.messages
      render :new, status: :bad_request
    end
  end


  def show
    @payment = Payment.where(id: params[:id])
    # @order =  @payment.order_id


  end


  private

  def payment_params
    params.require(:payment).permit(:name, :email, :mailing_address, :cc_name, :cc_expiration, :cc_number, :cc_ccv, :billing_zip)
  end

end
