require 'spec_helper'

describe KeychainsController do

  let(:user) { Fabricate(:user) }

  before do
    session[:user_id] = user.id
  end

  describe "GET index" do
    it "renders the index page" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    it "redirects user to index template" do
      post :create, :keychain => {:name => 'some name', :description => "some desc", :username => 'username', :password => 'thepassword'}
      expect(response).to redirect_to(keychains_path)
    end
  end
end
