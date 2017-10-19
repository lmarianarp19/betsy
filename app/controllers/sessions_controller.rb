class SessionsController < ApplicationController

  #TODO: REFACTOR FLASHES INTO THE APPLICATIONS CONTROLLER
  #TODO: CHECK AUTH HASH IN INTERACTIVE SHELL


  def login_form
  end

  def login
    # auth_hash = request.env['omniauth.auth']
    #
    # if auth_hash[:uid]

      # if merchant.nil?
      #   merchant = Merchant.from_auth_hash(params[:provider], auth_hash)
      #
      #   if merchant.save
      #     session[:merchant_id] = merchant.id
      #     flash[:status] = :success
      #     flash[:message] = "Successfully logged in as #{merchant.name}"
      #     redirect_to rooth_path
      #   else
      #     flash[:status] = :failure
      #     flash[:message] = "Could not log in! Please try again."
      #     flash[:errors] = merchant.errors.messages
      #   end

      # else
      #   session[:merchant_id] = merchant.id
      #   flash[:status] = :failure
      #   flash[:message] = "Could not log in! Please try again."
      #   flash[:errors] = merchant.errors.messages
      # end
      # redirect_to login_path
    # else
    #   session[:merchant_id] = merchant.id
    #   flash[:status] = :success
    #   flash[:message] = "Welcome back #{merchant.name}"
    #   redirect_to root_path
    # end
  end


  def logout
    session[:merchant_id] = nil
    flash[:status] = :failure
    flash[:message] = "Successfully logged out!"

    redirect_to root_path
  end

end
