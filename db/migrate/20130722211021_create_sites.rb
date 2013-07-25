class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |site|
      site.string :company
      site.string :site
      site.string :username
      site.string :pwhint
    end
  end
end
