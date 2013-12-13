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
end
