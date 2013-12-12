require 'spec_helper'

describe PasswordRecoveriesController do

  let(:user) { Fabricate(:user) }

  before do
    session[:user_id] = user.id
  end

  describe "GET new" do
    it "retrieves the recover password form" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    it "creates a new recovery link for the user" do
      post :create, :email => user.email
      expect(flash[:info].to_s).to include("You should receive an email with a link to reset your password")
      expect(response).to redirect_to(sign_in_path)
    end

    it "returns an danger if it can not find the email entered" do
      post :create, :email => "none@nonexisting.com"
      expect(flash.now[:danger]).to include("We could not find you in the system. Did you enter your email correctly?")
    end
  end

  describe "GET edit" do

    before do
      user.password_recoveries.create
    end

    it "presents a form to the user to enter the new password" do
      recovery = user.password_recoveries.last
      get :edit, :id => recovery.id, :token => recovery.token
      expect(response).to render_template(:edit)
    end

    it "returns an danger if the token can not be found" do
      incorrect_token_test(:edit)
    end
  end

  describe "PATCH update" do

    it "updates the user's password" do
      recovery = user.password_recoveries.create
      patch :update, :id => recovery.id, :token => recovery.token, :password => 'newpasswordhere', :password_confirmation => 'newpasswordhere'
      expect(response).to redirect_to(sign_in_path)
      expect(flash.now[:danger].to_s).to eq('')
      expect(flash[:info].to_s).to eq("Your password has been reset.")
    end

    it "returns an danger if the token can not be found" do
      incorrect_token_test(:update)
    end

    it "returns an danger if the password is blank" do
      recovery = user.password_recoveries.create
      patch :update, :id => recovery.id, :token => recovery.token, :password => '', :password_confirmation => 'otherpassword'
      expect(flash.now[:danger]).to include("Password can't be blank")
    end

  end

  def incorrect_token_test(action)
      recovery = user.password_recoveries.create
      patch action, :id => "1", :token => recovery.token+"abc", :password => 'newpasswordhere', :password_confirmation => 'newpasswordhere'
      expect(flash[:danger]).to include("The token is invalid. Please submit a new password recovery form.")
  end
end
