class MerchantsController < ApplicationController

  before_action only:[:show] do
    @try_merchant = Merchant.find_by(id: params[:id])
    restrict_merchant(@try_merchant)
  end

  def show
    @unfufilled = @merchant.orders_hash_by_status("paid").count
    @unfufilled_revenue = @merchant.sum_ord_hash("paid")
    @complete = @merchant.orders_hash_by_status("complete").count
    @complete_revenue = @merchant.sum_ord_hash("complete")
    @total = @unfufilled + @complete
    @total_revenue = @unfufilled_revenue + @complete_revenue
  end

  def products
    @merchant = Merchant.find(params[:merchant_id])
    if @login_merchant && @login_merchant.id == @merchant.id
      @access = true
    end
    @products = @merchant.products
  end
  
end
