class SessionsController < ApplicationController

  #TODO: REFACTOR FLASHES INTO THE APPLICATIONS CONTROLLER
  #TODO: CHECK AUTH HASH IN INTERACTIVE SHELL WHEN PASSING IN

  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      merchant = Merchant.find_by(provider: params[:provider], uid: auth_hash['uid'])
      if merchant.nil? # If merchant was not previously logged in
        merchant = Merchant.from_auth_hash(params[:provider], auth_hash)
        save_and_flash(merchant)
      else # If merchant previously existed
        session[:merchant_id] = merchant.id
        flash[:status] = :success
        flash[:message] = "Welcome back, #{merchant.username}"
      end
      session[:merchant_id] = merchant.id
      session[:merchant_username] = merchant.username
      #will log in the user
    else
      flash[:status] = :failure
      flash[:message] = "Failed to create a new user"
      #TODO: Not sure if the root_path is the correct reroute if an oath uid is not provided
    end

    redirect_to root_path
  end

  def logout
    if @login_merchant
      session[:merchant_id] = nil
      flash[:status] = :success
      flash[:message] = "Successfully logged out!"
    else
      flash[:status] = :failure
      flash[:message] = "You must be authorized to do that"
    end
    redirect_to root_path
  end

end
