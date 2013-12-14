class Notifications < ActionMailer::Base
  default from: ENV['admin_email']

  def recovery_email(recovery)
    @user = recovery.user
    @password_recovery = recovery
    mail(:to => @user.email, :subject => "You asked to reset your password")
  end

  def keychain_log_email(keychain)
    @keychain = keychain
    mail(:to => ENV['admin_email'], :subject => "Keychain: #{keychain.name} displayed.")
  end

end
