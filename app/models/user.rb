class User < ActiveRecord::Base
  attr_accessible :name, :email, :address, :phonenum, :role, :password_digest, :password , :password_confirmation, :remember_token
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save { |user| user.role = 'user' }


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :address, presence: true
  validates :phonenum, presence: true

  
  def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
  end
end
