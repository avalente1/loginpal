class User < ActiveRecord::Base
  has_many :sites

  has_secure_password

  validates :email, presence: true, uniqueness: true



end
