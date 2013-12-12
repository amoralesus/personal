module UserUtils
  def sign_in_user(the_user=nil)
    user = the_user || Fabricate(:user)
    visit sign_in_path
    fill_in 'email', :with => user.email
    fill_in 'password', :with => "password"
    click_button "Sign in"
  end
end

World(UserUtils)

