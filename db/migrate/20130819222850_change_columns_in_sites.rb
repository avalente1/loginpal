class ChangeColumnsInSites < ActiveRecord::Migration
  def change
    rename_column :sites, :username_key, :username_sb_key
    rename_column :sites, :username_iv, :username_sb_iv
  end
end
