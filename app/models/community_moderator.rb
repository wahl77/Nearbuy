class CommunityModerator < ActiveRecord::Base
  belongs_to :community
  belongs_to :user
end
