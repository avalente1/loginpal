class AddStrongBoxToSite < ActiveRecord::Migration
  def change
    add_column :sites, :pwhint_sb, :binary
    add_column :sites, :pwhint_sb_key, :binary
    add_column :sites, :pwhint_sb_iv, :binary
  end
end
