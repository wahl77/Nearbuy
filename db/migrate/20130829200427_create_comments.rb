class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :sender, index: true
      t.belongs_to :commentable, polymorphic: true
      t.boolean :public, default: true

      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
