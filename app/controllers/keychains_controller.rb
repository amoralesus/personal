class KeychainsController < ApplicationController
  def index
    @keychains = Keychain.all
  end

end
