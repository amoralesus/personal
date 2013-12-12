require 'spec_helper'

feature 'User signs in' do

  scenario "with existing credentials" do
    alice = Fabricate(:user)
    sign_in_user(alice)
    expect(page).to have_content alice.full_name
  end

  scenario "user signs out" do
    alice = Fabricate(:user)
    sign_in_user
    visit sign_out_path
    expect(page).to have_content "Sign in"
  end

end
