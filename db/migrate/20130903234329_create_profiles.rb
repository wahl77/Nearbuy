class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.float :distance_multiplier, default: 1
      t.string :first_name
      t.string :last_name
      t.references :user, index: true
      t.timestamps
    end
  end
end
