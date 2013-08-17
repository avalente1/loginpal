class Site < ActiveRecord::Base
  belongs_to :user

  validates :company, presence: true
  validates :username, presence: true
  validates :pwhint, presence: true

  before_save :update_site
  before_save :update_favicon

  def update_site
    self.site = "http://www.#{self.company.delete(" ")}.com"
  end

  def update_favicon
    self.favicon = "https://plus.google.com/_/favicon?domain=www.#{self.company.delete(" ")}.com"
  end
end
