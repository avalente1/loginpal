class User < ActiveRecord::Base
  has_many :sites

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
end
