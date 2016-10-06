class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      if user.admin?
        can :manage, :all
      else
        user_ability
      end
    end
    guest_ability
  end

  def user_ability
    can :create, [Question, Answer, Comment, Vote]
    can :update, [Question, Answer, Comment], user: user
  end

  def guest_ability
    can :read, :all  
  end
end
