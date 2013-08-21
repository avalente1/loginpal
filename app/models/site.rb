class Site < ActiveRecord::Base
  belongs_to :user

  validates :company, presence: true
  validates :username_sb, presence: true
  validates :pwhint_sb, presence: true

  before_save :update_site
  before_save :update_favicon

   encrypt_with_public_key :pwhint_sb,
     :key_pair => Rails.root.join('config','keypair.pem')

   encrypt_with_public_key :username_sb,
     :key_pair => Rails.root.join('config','keypair.pem')

  def update_site
    self.site = "http://www.#{self.company.delete(" ")}.com"
  end

  def update_favicon
    self.favicon = "https://plus.google.com/_/favicon?domain=www.#{self.company.delete(" ")}.com"
  end

end
