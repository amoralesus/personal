require 'spec_helper'


describe User do
  before(:each) do
    Fabricate(:user) # had to create user first because tests were failing with has_secure_password
  end

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:password) }

  it "should not save if password given without password confirmation" do
    user = User.new(:full_name => "Bob Martin", :email => "uncle@bob", :password => "factorial")
    user.save
    user.errors.should have_key(:password_confirmation)
  end

end
