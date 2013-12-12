class Notifications < ActionMailer::Base
  default from: "alberto@moralitos.com"

  def recovery_email(recovery)
    @user = recovery.user
    @password_recovery = recovery
    mail(:to => @user.email, :subject => "You asked to reset your password")
  end

end