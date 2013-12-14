Given(/^a logged in user$/) do
  sign_in_user
end

When(/^a user goes to the new keychain page$/) do
  visit new_keychain_path
end

When(/^fills out a keychain with name "(.*?)", description "(.*?)", :username => "(.*?)", :password => "(.*?)"$/) do |name, description, username, password|
  fill_in 'keychain_name', :with => name
  fill_in 'keychain_description', :with => description
  fill_in 'keychain_username', :with => username
  fill_in 'keychain_password', :with => password
end

When(/^submits the new keychain form$/) do
  click_on 'submit'
end

Then(/^the user is redirected to the keychains listing page$/) do
  expect(page.current_path).to eq('/keychains')
end

Then(/^the user can see a keychain with the name "(.*?)"$/) do |name|
  expect(page.body).to have_content(name)
end
