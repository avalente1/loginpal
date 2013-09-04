class Typeahead < ActiveRecord::Base
  before_save :update_favicon

  def update_favicon
    self.favicon = "https://plus.google.com/_/favicon?domain=www.#{self.url}"
  end
end
