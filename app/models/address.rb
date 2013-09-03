class Address < ActiveRecord::Base
  belongs_to :country
  belongs_to :addressable, polymorphic: true
  acts_as_gmappable check_process: true, validation: true
  reverse_geocoded_by :latitude, :longitude

  validates :city,
    presence:true

  validates :number_and_street,
    presence:true,
    length:{maximum: 250}

  validates :city,
    presence:true,
    length:{maximum: 50}

  validates :state,
    presence:true,
    length:{maximum: 50}

  def gmaps4rails_address
    return "#{number_and_street}, #{city}, #{country.name}"
  end


  # Find all items given an address
  def items
    return Item.where("address_id = ?", self.id)
  end

end
