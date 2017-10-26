class MerchantsController < ApplicationController

  before_action only:[:show] do
    @try_merchant = Merchant.find_by(id: params[:id])
    restrict_merchant(@try_merchant)
  end
  def show
    # if @merchant.products
      @unfufilled = @merchant.orders_hash_by_status("paid").count
      @unfufilled_revenue = @merchant.sum_ord_hash("paid")
      @complete = @merchant.orders_hash_by_status("complete").count
      @complete_revenue = @merchant.sum_ord_hash("complete")
      @total = @unfufilled + @complete
      @total_revenue = @unfufilled_revenue + @complete_revenue
    # else
    #   flash[:status] = :failure
    #   flash[:message] = "You must be authorized to do that"
    #   redirect_to root_path
    # end
  end

  def products
    # find_merchant
    @merchant = Merchant.find(params[:id])
    if @login_merchant && @login_merchant.id == @merchant.id
      @access = true
    end
    @products = @merchant.products
  end
end
