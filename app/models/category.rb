class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :items, through: :categorizations

  validates :name,
    presence:true,
    uniqueness:true

  def name=(value)
    write_attribute :name, value.capitalize
  end
end
