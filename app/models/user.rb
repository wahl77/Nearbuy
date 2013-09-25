class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # Here is where profile information should be stored
  has_one :profile, dependent: :destroy, inverse_of: :user

  accepts_nested_attributes_for :profile

  has_one :image, as: :imageable, dependent: :destroy # Profile picture
  accepts_nested_attributes_for :image, allow_destroy: true

  has_many :items, dependent: :destroy
  has_many :comments, through: :items

  has_many :addresses, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: lambda{|address| address[:number_and_street].blank? }


  # A user's communities
  has_many :community_members, -> { uniq }
  has_many :communities, -> { uniq }, through: :community_members

  # Communities a user moderates
  has_many :community_moderators, -> { uniq }
  has_many :moderating_communities, -> { uniq }, through: :community_moderators, source: :community

  has_many :admin_communities, class_name: "Community", foreign_key: "owner_id"



  before_create :make_profile


  validates :email,
    presence: true,
    uniqueness: true,
    format:{with:EMAIL_REGEX, multiline:true}

  validates :password,
    presence:true, on: :create,
    confirmation:true

  # Make sure a profile is associated with the user upon creation
  def make_profile
    self.profile = Profile.new if self.profile.nil?
  end

  #def first_name=(value)
  #  write_attribute :first_name, value.capitalize
  #end

  #def last_name=(value)
  #  write_attribute :last_name, value.capitalize
  #end

end
