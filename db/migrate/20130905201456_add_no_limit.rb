class AddNoLimit < ActiveRecord::Migration
  def change
    change_column :typeaheadtopsites, :description, :text, limit: nil
  end
end
