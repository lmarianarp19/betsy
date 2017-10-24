class MerchantsController < ApplicationController
  before_action only:[:show] do
    restrict_merchant(:id)
  end
  def show
    @unfufilled = @orders.where(status: "pending")
    @complete = @orders.where(status: "complete")
  end


  # 
  # def revenue(var)
  #   var.
  #
  # end
end
