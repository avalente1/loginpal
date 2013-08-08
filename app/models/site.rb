class Site < ActiveRecord::Base
  belongs_to :user

  validates :company, presence: true
  validates :username, presence: true
  validates :pwhint, presence: true

end
