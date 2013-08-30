class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.references :user, index: true
      t.references :address, index: true

      t.timestamps
    end
  end
end
