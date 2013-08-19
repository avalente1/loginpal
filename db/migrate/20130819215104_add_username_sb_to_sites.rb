class AddUsernameSbToSites < ActiveRecord::Migration
  def change
    add_column :sites, :username_sb, :binary
    add_column :sites, :username_key, :binary
    add_column :sites, :username_iv, :binary
  end
end
