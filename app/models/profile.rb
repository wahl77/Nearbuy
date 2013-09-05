class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :user, 
    presence: true

  def first_name=(value)
    write_attribute :first_name, value.capitalize
  end

  def last_name=(value)
    write_attribute :last_name, value.capitalize
  end

end
