class MerchantsController < ApplicationController
  before_action only:[:show] do
    restrict_merchant(params[:id])
  end

  def show
    @orders = @merchant.orders
    @unfufilled = @orders.where(status: "pending")
    
    @complete = @orders.where(status: "complete")
  end

  def products
    # find_merchant
    @merchant = Merchant.find_by(id: params[:merchant_id])
    if @login_merchant && @login_merchant.id == @merchant.id
      @access = true
    end
    @products = @merchant.products
  end
end
