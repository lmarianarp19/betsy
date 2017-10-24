class OrdersController < ApplicationController

  def index
    @merchant = Merchant.find_by(id: params[:merchant_id])
    @orders = @merchant.orders.distinct
  end

  def show
    @order = Order.find_by(id: params[:id])
    # render_404 unless @order
    unless @order
      head :not_found
    end

  end


  def create
    @order = Order.new(status: "paid")
    unless @order.save
      flash[:status] = :failure
      flash[:message] = "Could not create a new order. Please try again!"
      #flash[:errors] = @review.errors.messages
    end
  end

  # def update
  #   @order.update_attributes(orders_params)
    #if @order.save
      # if @order.payment_id
      #   @order.status = "paid"
      #   flash[:status] = :success
      #   flashs[:message] = "Your payment was receive. Thanks for shopping."
      #   redirect_to root_path
      # else
      #   flash[:status] = :failure
      #   flash[:message] = "Invalid payment information"
      #   flash[:erros] = @order.errors.messages
      #   redirect_to new_payment_path
      #   render "payment/show"
      # end
    # unless @order.save
    #   flash[:status] = :failure
    #   flash[:message] = "Could not update your order"
    #   flash[:errors] = @order.errors.messages
    #   redirect_to root_path
    # end


#  end


  def destroy # CANCEL
    if @order.destroy
      flash[:status] = :success
      flash[:message] = "Your order was canceled! May the force be with you!"
    else
      flash[:status] = :failure
      flash[:message] = "Whoops! Your order could not be canceled!"
      #flash[:errors] = @order.errors.messages
    end
  end

  private

  def orders_params
    params.require(:order).permit(:order_status)
  end
end
