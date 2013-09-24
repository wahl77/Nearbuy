class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.references :owner, index: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
