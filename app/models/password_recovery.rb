class PasswordRecovery < ActiveRecord::Base
  belongs_to :user

  after_create :set_initial_status
  after_create :recovery_mailer_delivery

  include Tokenable

  def self.pending
    where(:status => 'pending')
  end

  def complete!(password, password_confirmation) 
    begin
      self.user.password = password
      self.user.password_confirmation = password_confirmation
      self.user.save!
      self.status = 'completed'
      self.save!
    rescue 
      self.user.errors.full_messages.each {|error| self.errors.add(:base, error)}
      return false
    end
  end

  private

  def set_initial_status
    self.user.password_recoveries.pending.update_all(:status => 'expired')
    self.status = 'pending'
    self.save
  end

  def recovery_mailer_delivery
    Notifications.recovery_email(self).deliver
  end
end
