require "test_helper"

describe SessionsController do
  describe "#login" do
    it "logs in an existing user and redirects to the root path" do
      start_count = Merchant.count

      # Get a user from the fixtures
      merchant = merchants(:grace)

      login(merchant)

      session[:merchant_id].must_equal merchant.id
      Merchant.count.must_equal start_count
    end

    it "creates an account for a new user and redirects to the root route" do
    #   start_count = Merchant.count
    #   #TODO: HOW THE EFF DO I PASS THIS IN AS HASH???? I'M NOT PASSING THIS IN CORRECTLY
    #   # merchant = {
    #   #   username: "John",
    #   #   email: "johndoe@gmail.com",
    #   #   uid: 77777777,
    #   #   provider: "github"
    #   # }
    #
    #   # binding.pry
    #   login(merchant)
    #
    #   session[:merchant_id].must_equal merchant.id
    #   Merchant.count.must_equal start_count + 1
    # end
    # #
    # it "redirects to root_path if given invalid user data" do
    #   merchant = merchants(:grace)
    #   merchant[:uid] = ""
    #
    #   login(merchant)
    #
    #   flash[:status].must_equal :failure
    #   must_respond_with :redirect
    #   must_redirect_to root_path
    #   session[:merchant_id].must_be_nil
    # end
  end
end

  describe "#logout" do
    it "returns success if a user logged out" do
      merchant = merchants(:grace)
      login(merchant)
      session[:merchant_id].must_equal merchant.id

      logout

      session[:merchant_id].must_be_nil
      flash[:status].must_equal :success
      must_redirect_to root_path
    end

    it "returns an unauthorized flash message if the merchant is not logged in" do
      logout

      session[:merchant_id].must_be_nil
      flash[:status].must_equal :failure
      must_redirect_to root_path
    end
  end
end
