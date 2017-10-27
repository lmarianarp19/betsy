class PaymentsController < ApplicationController
  # before_action only:[:show] do
  #   @try_merchant = Merchant.find_by(id: params[:id])
  #   restrict_merchant(@try_merchant)
  # end

  def new # Show the form for billing info
    order =  order_find_by_params
    # order =  Order.find_by(id: params[:order_id])
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
      order = order_find_by_params
      # order =  Order.find_by(id: params[:order_id])

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
      flash[:details] = @payment.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    @try_merchant = Merchant.find_by(id: params[:id])
    restrict_merchant(@try_merchant)
    # TODO: need to restrict this so that only merchants with products in the order can access.
    @payment = Payment.where(id: params[:id])
    # @order =  @payment.order_id
  end

private
  def payment_params
    params.require(:payment).permit(:name, :email, :mailing_address, :cc_name, :cc_expiration, :cc_number, :cc_ccv, :billing_zip)
  end

  def order_find_by_params
    return Order.find_by(id: params[:order_id])
  end
end
