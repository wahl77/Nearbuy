class Community < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  has_many :community_members, -> { uniq }, dependent: :destroy
  has_many :members, -> { uniq }, through: :community_members, source: :user

  has_many :community_moderators, -> { uniq }, dependent: :destroy
  has_many :moderators, -> { uniq }, through: :community_moderators, source: :user


  # Add multiple users at once
  def add_members(*users)
    users.each do |user|
      self.members << user
    end
  end

  def add_member(user)
    self.members << user
  end

  def remove_members(*users)
    self.members = self.members - users
  end

  def remove_member(user)
    self.members.delete(user)
  end
end
