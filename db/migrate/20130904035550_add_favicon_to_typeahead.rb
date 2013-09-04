class AddFaviconToTypeahead < ActiveRecord::Migration
  def change
    add_column :typeaheads, :favicon, :string
  end
end
