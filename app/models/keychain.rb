class Keychain < ActiveRecord::Base
  attr_accessor :password

  validates :name, :presence => true, :uniqueness => true

  def self.key
    ActiveSupport::KeyGenerator.new(Rails.configuration.key).generate_key(Rails.configuration.salt)
  end

  def self.encryptor
    ActiveSupport::MessageEncryptor.new(self.key)
  end

  def password=(value)
    @password = value
    encrypt_password
  end

  def password
    @password || decrypt_password
  end

  private

  def encrypt_password
    self.password_digest = Keychain.encryptor.encrypt_and_sign(self.password.to_s)
  end

  def decrypt_password
    Notifications.keychain_log_email(self).deliver
    Keychain.encryptor.decrypt_and_verify(self.password_digest)
  end

end
