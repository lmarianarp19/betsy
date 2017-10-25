class MerchantsController < ApplicationController
  before_action only:[:show] do
    restrict_merchant(params[:id])
  end

  def show
    @merchant.products
    @unfufilled = @merchant.orders_hash_by_status("paid").count
    @unfufilled_revenue = @merchant.sum_ord_hash("paid")
    @complete = @merchant.orders_hash_by_status("complete").count
    @complete_revenue = @merchant.sum_ord_hash("complete")
    @total = @unfufilled + @complete
    @total_revenue = @unfufilled_revenue + @complete_revenue
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
