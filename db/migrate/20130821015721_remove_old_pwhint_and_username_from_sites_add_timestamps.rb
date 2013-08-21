class RemoveOldPwhintAndUsernameFromSitesAddTimestamps < ActiveRecord::Migration
  def change
    remove_column :sites, :pwhint
    remove_column :sites, :username
    add_column :sites, :created_at, :datetime
    add_column :sites, :updated_at, :datetime
  end
end
