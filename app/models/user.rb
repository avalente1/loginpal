class User < ActiveRecord::Base
  has_many :sites

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  before_save { generate_token(:auth_token) }


  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
