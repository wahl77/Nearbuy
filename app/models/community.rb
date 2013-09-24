class Community < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  has_many :community_members, -> { uniq }, dependent: :destroy
  has_many :members, -> { uniq }, through: :community_members, source: :user

  has_many :community_moderators, -> { uniq }, dependent: :destroy
  has_many :moderators, -> { uniq }, through: :community_moderators, source: :user


  # Add multiple users at once
  def add_members(*users)
    self.members << users
  end
  alias_method :add_member, :add_members


  # Remove multiple users at once
  def remove_members(*users)
    self.members.delete users
  end
  alias_method :remove_member, :remove_members

end
