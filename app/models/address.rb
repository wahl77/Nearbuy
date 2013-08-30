class Address < ActiveRecord::Base
  belongs_to :country
  belongs_to :addressable, polymorphic: true
  acts_as_gmappable
  reverse_geocoded_by :latitude, :longitude

  def gmaps4rails_address
    return "#{number_and_street}, #{city}, #{country.name}"
  end


  # Find all items given an address
  def items
    return Item.where("address_id = ?", self.id)
  end

end
