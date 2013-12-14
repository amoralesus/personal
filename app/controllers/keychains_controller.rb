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
      flash.now[:danger] = "Could not save keychain. #{@keychain.errors.full_messages.join(', ')}"
      render :action => :new
    end
  end

  def show
    @keychain = Keychain.find(params[:id])
  end

  def destroy
    @keychain = Keychain.find(params[:id])
    @keychain.destroy
    redirect_to keychains_path
  end

  def edit
    @keychain = Keychain.find(params[:id])
  end

  def update
    @keychain = Keychain.find(params[:id])
    if @keychain.save
      redirect_to keychain_path(@keychain)
    else
      flash.now[:danger] = "Could not update record. #{@keychain.errors.full_messages.join(', ')}"
      render :action => :edit
    end
  end

  private

  def keychain_params
    params.require(:keychain).permit(:name, :description, :password, :username)
  end

end
