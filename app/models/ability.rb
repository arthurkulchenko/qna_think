class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    return guest_ability unless user
    return user_ability unless user.admin?
     ( can :manage, :all )
  end

  def user_ability
    can [:create, :update, :destroy], [Question, Answer, Comment, Attachment], user: user
    
    can [:profiles, :me], User
    can :vote, [Answer, Question] do |parent|
      !user.is_author_of?(parent)
    end
    can :destroy, Vote, user: user
    can_by_default
  end

  def guest_ability
    can_by_default
  end

  def can_by_default
    can :read, :all
  end

end