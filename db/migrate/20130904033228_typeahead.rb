class Typeahead < ActiveRecord::Migration
  def change
    create_table :typeaheadtopsites do |t|
      t.string :company
      t.string :url
      t.string :description
      t.string :stars
      t.string :favicon
      t.timestamps
    end
  end
end
