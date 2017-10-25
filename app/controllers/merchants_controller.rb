class MerchantsController < ApplicationController
  before_action only:[:show] do
    restrict_merchant(params[:id])
  end

  def show
    @total = @merchant.orders
    @unfufilled = @merchant.orders_hash_by_status("pending")
    @complete = @merchant.orders_hash_by_status("complete")
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
