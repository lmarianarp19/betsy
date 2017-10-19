require "test_helper"

describe SessionsController do
  describe "auth_callback" do
    it "logs in an existing user and redirects to the root route" do
      start_count = Merchant.count

      # Get a user from the fixtures
      user = users(:grace)

      # Tell OmniAuth to use this user's info when it sees
      # an auth callback from github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Send a login request for that user
      # Note that we're using the named path for the callback, as defined
      # in the `as:` clause in `config/routes.rb`
      get auth_callback_path(:github)

      must_redirect_to root_path

      # Since we can read the session, check that the user ID was set as expected
      session[:merchant_id].must_equal merchant.id

      # Should *not* have created a new user
      Merchant.count.must_equal start_count
    end

    # it "creates an account for a new user and redirects to the root route" do
    # end
    #
    # it "redirects to the login route if given invalid user data" do
    # end
  end
end
