require 'spec_helper'

describe PasswordRecovery do
  it { should belong_to(:user) }

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:password_recovery) }
  end

  let(:user) { Fabricate(:user) }

  describe "at creation" do

    it "has a status of pending" do
      password_recovery = user.password_recoveries.create
      expect(password_recovery.status).to eq('pending')
    end

    it "sets all other statuses as expired" do
      password_recovery = user.password_recoveries.create
      password_recovery2 = user.password_recoveries.create
      expect(password_recovery.reload.status).to eq('expired')
    end

    it "sends an email to the user to reset password" do
      password_recovery = user.password_recoveries.create
      expect(ActionMailer::Base.deliveries).not_to eq([])
      expect(ActionMailer::Base.deliveries.last.subject).to eq("You asked to reset your password")
    end

    it "sends an email to the user with a url to go to" do
      password_recovery = user.password_recoveries.create
      expect(ActionMailer::Base.deliveries.last.body).to include("/password_recoveries/#{password_recovery.id}/edit?token=#{password_recovery.token}")
    end

  end

  describe "when the user enters the new password" do

    let(:password_recovery) { user.password_recoveries.create }

    it "resets the user password" do
      password_recovery.complete!('newonehere', 'newonehere')
      expect(password_recovery.errors.full_messages).to eq([])
      expect(user.reload.authenticate('newonehere')).to eq(user)
    end

    it "presents an danger if the password confirmation is not correct" do
      password_recovery.complete!("onepassword", "notmatchingpassword")
      expect(password_recovery.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
