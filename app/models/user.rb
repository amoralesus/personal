class User < ActiveRecord::Base

  validates :email, :presence => true, :uniqueness => true
  validates :full_name, :presence => true
  validates :password, :presence => true
  has_many :password_recoveries
  
  has_secure_password

end