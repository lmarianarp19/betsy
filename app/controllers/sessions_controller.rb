class SessionsController < ApplicationController

  #TODO: REFACTOR FLASHES INTO THE APPLICATIONS CONTROLLER
  #TODO: CHECK AUTH HASH IN INTERACTIVE SHELL


  def login_form
  end

  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      merchant = Merchant.find_by(uid: auth_hash['uid'])

      if merchant.nil? # If merchant is not found, create a new merchant
        merchant = Merchant.from_auth_hash(params[:provider], auth_hash)

        if merchant.save
          session[:merchant_id] = merchant.id
          flash[:status] = :success
          flash[:message] = "Successfully logged in created user: #{merchant.username}"
          #TODO:  Must redirect to login_form???
          redirect_to root_path
        else
          flash[:status] = :failure
          flash[:message] = "Could not log in! Please try again"
          flash[:errors] = merchant.errors.messages
        end

      else # If merchant is found!
        session[:merchant_id] = merchant.id
        flash[:status] = :success
        flash[:message] = "Welcome back #{merchant.username}"

        redirect_to root_path
      end
    end
  end


  def logout
    session[:merchant_id] = nil
    flash[:status] = :failure
    flash[:message] = "Successfully logged out!"

    redirect_to root_path
  end

end
