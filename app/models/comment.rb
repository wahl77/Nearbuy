class Comment < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :commentable, polymorphic: true

  def public?
    return self.public
  end
end
