class SessionsController < ApplicationController
  include SessionsHelper

  attr_reader :user
  def new
  end
  def create
    user = User.find_by email: params_session[:email].downcase
    if user && user.authenticate(params_session[:password])
      login_success user
    else
      login_false user
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  private
  def login_success user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_to user
  end

  def login_false user
    flash.now[:danger] = t ".danger"
    render :new
  end
end
