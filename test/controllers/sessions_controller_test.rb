require "test_helper"

describe SessionsController do
  describe "#login" do
    it "logs in an existing user and redirects to the root path" do
      merchant = merchants(:grace)
      login(merchant)
      session[:merchant_id].must_equal merchant.id
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "creates an account for a new user and redirects to the root path" do
      start_count = Merchant.count
      merchant = Merchant.new(provider: "github", uid: 77777777, username: "MasterYoda", email: "MasterYoda@gmail.com")

      login(merchant)
      session[:merchant_id].must_equal Merchant.last.id
      Merchant.count.must_equal start_count + 1
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "redirects to root_path if given invalid user data" do
      merchant = merchants(:grace)
      merchant[:uid] = ""

      login(merchant)

      flash[:status].must_equal :failure
      must_respond_with :redirect
      must_redirect_to root_path
      session[:merchant_id].must_be_nil
    end

    it "logged in user cannot log in again" do
      start_count = Merchant.count
      merchant = merchants(:grace)
      login(merchant)
      login(merchant)
      Merchant.count.must_equal start_count
    end
  end


  describe "#logout" do
    it "returns success if a user logged out and session id is nil" do
      merchant = merchants(:grace)
      login(merchant)
      session[:merchant_id].must_equal merchant.id

      logout

      session[:merchant_id].must_be_nil
      flash[:status].must_equal :success
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "returns an unauthorized flash message if the merchant is not logged in" do
      logout

      session[:merchant_id].must_be_nil
      flash[:status].must_equal :failure
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
