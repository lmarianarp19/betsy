require "test_helper"

describe MerchantsController do

  let(:merchant) { Merchant.first }

  describe "#show" do
    it "returns success when showing a merchant show page" do
      merchant.must_be :valid?

      get merchant_path(merchant.id)

      must_respond_with :success
    end

    it "returns not found if the merchant_id is not found" do
      invalid_merchant_id = Merchant.last.id + 1

      get merchant_path(invalid_merchant_id)

      must_respond_with :not_found
    end
  end

end
