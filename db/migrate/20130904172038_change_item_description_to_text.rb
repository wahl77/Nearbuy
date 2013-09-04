class ChangeItemDescriptionToText < ActiveRecord::Migration
  def change
    change_column :items, :description, :text
  end
end
