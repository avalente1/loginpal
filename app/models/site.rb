class Site < ActiveRecord::Base
  belongs_to :user

  validates :company, presence: true
  validates :username_sb, presence: true
  validates :pwhint_sb, presence: true

  before_save :update_site

   encrypt_with_public_key :pwhint_sb,
     :key_pair => Rails.root.join('config','keypair.pem')

   encrypt_with_public_key :username_sb,
     :key_pair => Rails.root.join('config','keypair.pem')

  def update_site
    site_found = Typeaheadtopsite.find_by(company: self.company)
    if site_found.present?
      self.site = site_found.url
      self.favicon = site_found.favicon
    else
      self.site = "#{self.company.delete(" ")}.com"
      self.favicon = "https://plus.google.com/_/favicon?domain=www.#{self.company.delete(" ")}.com"
    end
  end

end
