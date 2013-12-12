class Keychain < ActiveRecord::Base
  attr_accessor :password

  validates :name, :presence => true, :uniqueness => true

  def password=(value)
    @password = value
    encrypt_password
  end

  def password
    @password || decrypt_password
  end

  private

  def encrypt_password
    self.password_digest = Rails.configuration.encryptor.encrypt_and_sign(self.password.to_s)
  end

  def decrypt_password
    Rails.configuration.encryptor.decrypt_and_verify(self.password_digest)
  end

end
