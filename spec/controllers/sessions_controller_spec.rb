require 'spec_helper'

describe SessionsController do

  describe "GET sign-in" do
    it "should show the login page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create session" do
    before(:each) do
      Fabricate(:user, :email => 'myemail@other.com', :password => 'password', 
                         :password_confirmation => 'password')
    end

    it "should set the session user_id after successful login" do
      post :create, :email => 'myemail@other.com', :password => 'password'
      expect(session[:user_id]).to eq(User.first.id)
    end

    it "should redirect to the home page after successful login" do
      post :create, :email => 'myemail@other.com', :password => 'password'
      expect(response).to redirect_to root_path
    end

    it "should render the new session page if user entered incorrect email" do
      post :create, :email => 'myemail@oter.com', :password => 'password'
      expect(response).to render_template(:new)
      expect(flash.now[:danger]).to include('could not log you in')
    end

    it "should render the new session page if user entered incorrect password" do
      post :create, :email => 'myemail@other.com', :password => 'ord'
      expect(response).to render_template(:new)
      expect(flash.now[:danger]).to include('could not log you in')
    end
  end

end
