require "test_helper"

describe ProductsController do
  describe "index" do
    it "returns success when showing all products" do
      get products_ppath

      must_respond_with :success
    end

    #TODO: Need to make an alternative

    it "returns success when a product show page" do
    end
  end
end
