class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :number_and_street
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :name, default: "Home"
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.references :country, index: true
      t.belongs_to :addressable, polymorphic:true

      t.timestamps
    end
  end
end
