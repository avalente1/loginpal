class Typeahead < ActiveRecord::Migration
  def change
    create_table :typeaheads do |t|
      t.string :company
      t.string :url
      t.string :description
      t.string :stars
      t.timestamps
    end
  end
end
