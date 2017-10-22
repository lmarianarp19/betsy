require "test_helper"

describe MerchantsController do

  let(:merchant) { Merchant.first }

  describe "#show" do
    it "returns success when showing a merchant show page" do
      login(merchant)

      merchant.must_be :valid?

      get merchant_path(merchant)

      must_respond_with :success
    end

    it "returns not found if the merchant_id is not found" do
      login(merchant)

      invalid_merchant_id = Merchant.last.id + 1

      get merchant_path(invalid_merchant_id)

      must_respond_with :not_found
    end

    it "returns redirect to root path if the merchant is not logged in" do
      get merchant_path(merchant)

      must_respond_with :redirect
      must_redirect_to root_path
      flash[:status].must_equal :failure
    end
  end
end
