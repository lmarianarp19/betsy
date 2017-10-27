require "test_helper"

describe MerchantsController do

  let(:merchant) { Merchant.first }

  describe "#show" do
    describe "logged in merchant" do
      it "returns success when showing a merchant show page" do
        login(merchant)
        merchant.must_be :valid?

        get merchant_path(merchant)

        must_respond_with :success
      end

      it "returns success if the merchant has no summary of products" do
        merchant.products.destroy_all
        login(merchant)

        get merchant_path(merchant)

        must_respond_with :success
      end
    end

    describe "guest" do
      it "returns redirect to root path if the merchant is not logged in" do
        get merchant_path(merchant)

        must_respond_with :redirect
        must_redirect_to root_path
        flash[:status] = :failure
      end
    end
  end



  describe "#products" do
    describe "logged in merchant" do
      it "returns success if the merchant has products" do
        login(merchant)

        get merchant_products_path(merchant)

        must_respond_with :success
      end

      # it "return success if the merchant has no current products" do
      #   merchant.products.destroy_all
      #
      #   get merchant_product_path(merchant)
      #
      #   must_respond_with :success
      # end
    end

    describe "guest" do
      it "returns success if the merchant has products" do
        get merchant_products_path(merchant)

        must_respond_with :success
      end

      it "return success if the merchant has no products" do

      end

      it ""
    end
  end
end
