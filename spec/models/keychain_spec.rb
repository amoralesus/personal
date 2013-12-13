require 'spec_helper'

describe Keychain do

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  let(:keychain) { Keychain.new(:name => "my key", :username => "some user", :password => "onetwo!!three", :description => "the description goes here") }

  before do
    ActionMailer::Base.deliveries = []
  end

  it "encrypts the password" do
    keychain.save
    expect(keychain.reload.password_digest).not_to be_blank
  end

  it "decrypts the password" do
    keychain.save
    expect(Keychain.first.password).to eq("onetwo!!three")
  end

  it "should email admin every time keychain is decrypted" do
    keychain.save
    Keychain.first.password
    expect(ActionMailer::Base.deliveries.size).to eq(1)
    expect(ActionMailer::Base.deliveries.first.subject).to eq("Keychain: #{keychain.name} displayed.")
  end
end
