class Notifications < ActionMailer::Base
  default from: "alberto@moralitos.com"

  def recovery_email(recovery)
    @user = recovery.user
    @password_recovery = recovery
    mail(:to => @user.email, :subject => "You asked to reset your password")
  end

  def keychain_log_email(keychain)
    @keychain = keychain
    mail(:to => 'alberto@moralitos.com', :subject => "Keychain: #{keychain.name} displayed.")
  end

end
