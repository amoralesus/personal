require 'spec_helper'

feature "forgot your password feature" do

  background do
    Fabricate(:user, :email => "jane@doe.com")
    #clear_emails
    ActionMailer::Base.deliveries = []
  end

  scenario "a user forgets his password and gets his email to retrieve" do
    visit sign_in_path
    click_link 'Forgot Password'
    fill_in :email, :with => 'jane@doe.com'
    click_button 'Send Email'
    expect(page).to have_content("You should receive an email with a link to reset your password")

    #visit_link_from_email_received
    click_link_from_email_received

    fill_in :password, :with => 'mypassword'
    fill_in :password_confirmation, :with => 'mypassword'
    click_button "Reset Password"

    expect(page).to have_content("Your password has been reset")
    expect(current_path).to eq('/sign_in')
  end

  def visit_link_from_email_received
    email = ActionMailer::Base.deliveries.last
    doc = Nokogiri::HTML(email.body.to_s)
    href = doc.css("a").first.attr('href')
    visit href
  end

  def click_link_from_email_received
    open_email("jane@doe.com")
    current_email.click_link 'link'
  end

end


