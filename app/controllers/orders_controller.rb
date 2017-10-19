class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  # def new
  #   @order = Order.new
  # end

  def create
    # Need to get the params id billings info page
    @order = Order.new(status: "paid", billing_id: params[:id])
  end

  def update
    @order = Order.new
    #TODO: Can guests update their order or only cancel them?
  end

  def destroy # CANCEL
    if @order.destroy
      flash[:status] = :success
      flash[:message] = "Your order was canceled! May the force be with you!"
    else
      flash[:status] = :failure
      flash[:message] = "Whoops! Your order could not be canceled!"
      flash[:errors] = @order.errors.messages
    end
  end

  private
  def order_params
    params.require(:order).permit(:order_status, :billing_info)
  end
end
