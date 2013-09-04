class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new # guest user (not logged in)
    can :create, Item
    can :read, Item
    can :around_me, Item
    can [:update, :destroy], Item do |item| 
      item && item.user == user 
    end

    can :create, User
    can :read, User do |some_user|
      some_user == user
    end
    can :update, User do |some_user|
      some_user == user 
    end

    can :create, Address
    can [:read, :update], Address do |address|
      user.addresses.include? address
    end
    can :destroy, Address do |address|
      (user.addresses.include? address) && (address.items.empty?)
    end


    can :create, Comment
    can :read, Comment do |comment|
      comment.public? || (user == comment.sender) || (user.comments.include? comment)
    end
    can :destroy, Comment do |comment|
      user == comment.sender
    end

    can :create, Profile
    can :read, Profile
    can :update, Profile do |profile|
      user.profile == profile
    end

    can :manage, Image
  end
end
