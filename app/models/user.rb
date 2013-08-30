class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one :image, as: :imageable, dependent: :destroy # Profile picture
  accepts_nested_attributes_for :image, allow_destroy: true

  has_many :items, dependent: :destroy

  has_many :addresses, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: lambda{|address| address[:num_and_street].blank? }

  validates :email,
    presence: true,
    uniqueness: true,
    format:{with:EMAIL_REGEX, multiline:true}

  validates :password,
    presence:true, on: :create,
    confirmation:true

  def first_name=(value)
    write_attribute :first_name, value.capitalize
  end

  def last_name=(value)
    write_attribute :last_name, value.capitalize
  end

end
