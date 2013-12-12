require 'spec_helper'

describe Keychain do

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  let(:keychain) { Keychain.new(:name => "my key", :username => "some user", :password => "onetwo!!three", :description => "the description goes here") }

  it "encrypts the password" do
    keychain.save
    expect(keychain.reload.password_digest).not_to be_blank
  end

  it "decrypts the password" do
    keychain.save
    expect(Keychain.first.password).to eq("onetwo!!three")
  end
end
