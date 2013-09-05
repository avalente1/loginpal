class ChangeColumnTypetoText < ActiveRecord::Migration
  def change
    change_column :typeaheadtopsites, :description, :text
  end
end
