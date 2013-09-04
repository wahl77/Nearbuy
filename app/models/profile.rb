class Profile < ActiveRecord::Base
  belongs_to :user

  validates :user, 
    presence: true

  def first_name=(value)
    write_attribute :first_name, value.capitalize
  end

  def last_name=(value)
    write_attribute :last_name, value.capitalize
  end

  def distance_units
    case distance_multiplier
    when 1
      "kilometres"
    when 0.621371
      "miles"
    else
      "undefined"
    end
  end
end
