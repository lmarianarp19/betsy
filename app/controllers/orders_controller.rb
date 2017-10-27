class OrdersController < ApplicationController

  # TODO: TAKE ALOOK AT THIS. WHAT IS THE MERCHANT ID COMING FROM? SESSIONS? ALREADY A @LOGIN_MERCHANT
  before_action only:[:index] do
    restrict_merchant(params[:merchant_id])
  end

  def index
    if @login_merchant
      # @merchant = Merchant.find_by(id: params[:merchant_id])
      @orders = @merchant.distinct_orders
      @paid_orders_hash = @merchant.orders_hash_by_status("paid")
      # @paid_total = @merchant.sum_ord_hash("paid")
      @complete_orders_hash = @merchant.orders_hash_by_status("complete")
      # @complete_total = @merchant.sum_ord_hash("complete")
    else
      flash_unathorized
      redirect_to root_path
    end
  end

  def show
    @order = Order.find_by(id: params[:id])

    unless @order
      head :not_found
    end
  end

  private

  def order_items_params
    params.permit(:quantity, :product_id)
  end
end
