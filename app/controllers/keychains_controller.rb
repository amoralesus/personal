class KeychainsController < ApplicationController
  def index
    @keychains = Keychain.all
  end

  def new
    @keychain = Keychain.new
  end

  def create
    @keychain = Keychain.new(keychain_params)
    if @keychain.save
      redirect_to keychains_path
    else
      flash[:danger] = "Could not save keychain. #{@keychain.errors.full_messages.join(', ')}"
      render :action => :new
    end
  end

  private

  def keychain_params
    params.require(:keychain).permit(:name, :description, :password, :username)
  end

end
