class SessionsController < ApplicationController
  skip_before_filter :authenticate

  def new
    redirect_to root_path if current_user
  end

  def create
    user = User.where(:email => params[:email]).first
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:danger] = "We could not log you in. Please try again or contact us for assistance."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
