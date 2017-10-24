class MerchantsController < ApplicationController
  before_action only:[:show] do
    restrict_merchant(:id)
  end

  def show
  end

end
