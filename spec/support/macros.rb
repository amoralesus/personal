def set_current_user
  joe = Fabricate(:user)
  session[:user_id] = joe.id
  joe
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def sign_in_user(the_user=nil)
  user = the_user || Fabricate(:user)
  visit sign_in_path
  fill_in 'email', :with => user.email
  fill_in 'password', :with => "password"
  click_button "Sign in"
end
