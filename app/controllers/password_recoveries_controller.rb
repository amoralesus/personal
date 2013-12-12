class PasswordRecoveriesController < ApplicationController
  skip_before_filter :authenticate

  def new
    @password_recovery = PasswordRecovery.new
  end

  def create
    user = User.where(:email => params[:email]).first
    @password_recovery = user ? user.password_recoveries.new : PasswordRecovery.new
    if user and @password_recovery.save
      flash[:info] = "You should receive an email with a link to reset your password"
      redirect_to sign_in_path
    else
      flash.now[:danger] = "We could not find you in the system. Did you enter your email correctly?"
      render :new
    end
  end

  def edit
    @password_recovery = PasswordRecovery.pending.where(:token => params[:token]).first
    if @password_recovery
      # render edit
    else
      redirect_to sign_in_path
      flash[:danger] = "The token is invalid. Please submit a new password recovery form."
    end
  end

  def update
    @password_recovery = PasswordRecovery.pending.where(:token => params[:token]).first
    if @password_recovery and @password_recovery.complete!(params[:password], params[:password_confirmation])
      flash[:info] = "Your password has been reset."
      redirect_to sign_in_path
    elsif @password_recovery
      flash.now[:danger] = @password_recovery.errors.full_messages.join(', ')
      render :edit
    else
      flash[:danger] = "The token is invalid. Please submit a new password recovery form."
      redirect_to sign_in_path
    end
  end
end
