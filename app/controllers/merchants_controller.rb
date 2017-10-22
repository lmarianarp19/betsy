class MerchantsController < ApplicationController

  def show
    if @login_merchant
      @merchant = Merchant.find_by(id: params[:id])
      unless @merchant
        head :not_found
      end
    else
      flash[:status] = :failure
      flash[:message] = "You must be authorized to do that"
      redirect_to root_path
    end
  end

end
