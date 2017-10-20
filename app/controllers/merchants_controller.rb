class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find_by(id: params[:id])
    unless @merchant
      head :not_found
    end
  end

  # TODO: May not need these if a merchant will be created in the model method.
  # TODO: See Sessions Controller



end
