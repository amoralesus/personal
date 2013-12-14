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

    it "renders the new action if the entry is incomplete" do
      post :create, :keychain => {:name => ""}
      expect(response).to render_template(:new)
      expect(flash[:danger]).to include("Name can't be blank")
    end
  end


  describe "member" do
    before do
      Fabricate(:keychain)
    end
    describe "GET show" do
      it "renders the detail page" do
        get "show", :id => Keychain.first.id
        expect(response).to render_template(:show)
      end
    end

    describe "DELETE destroy" do
      it "redirects to keychains listing after deleting a keychain" do
        delete "destroy", :id => Keychain.first.id
        expect(response).to redirect_to(keychains_path)
      end
    end

    describe "GET edit" do
      it "renders the edit page" do
        get :edit, :id => Keychain.first.id
        expect(response).to render_template(:edit)
      end
    end

    describe "PATCH update" do
      it "redirects to the show page after update" do
        patch :update, :id => Keychain.first.id, :keychain => {:name => "new name"}
        expect(response).to redirect_to(keychain_path(Keychain.first))
      end

      it "renders the edit action if data is incomplete" do
        patch :update, :id => Keychain.first.id, :keychain => {:name => ""}
        expect(response).to render_template(:edit)
        expect(flash.now[:danger]).to include("Name can't be blank")
      end
    end
  end


end
