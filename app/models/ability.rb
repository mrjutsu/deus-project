class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user.super_admin?
      can :manage, :all
    end
    if current_user.admin?
      can :manage, :all
      cannot :destroy, [User,Teaching]
    end
    if current_user.editor?
      can :manage, [Teaching,Favorite]
      can [:create, :destroy], Comment
      cannot :destroy, Teaching
    end
    if current_user.normal?
      can :read, :all
      can :create, [Teaching,Comment,Favorite]
      can :destroy, [Comment,Favorite]
      cannot :destroy, Teaching
    end
  end
end
