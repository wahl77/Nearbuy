class Country < ActiveRecord::Base

  validates :name,
    presence: true,
    uniqueness: true

  def name=(value)
    write_attribute :name, value.capitalize
  end

end
