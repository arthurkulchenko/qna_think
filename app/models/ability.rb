class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? ( can :manage, :all ) : ( user_ability )
    end
    guest_ability
    # can :manage, :all
  end

  def user_ability
    can :vote, [Answer, Question] do |parent|
      !user.is_author_of?(parent)
    end
    can :destroy, Vote, user_id: user.id
    can [:create, :update, :destroy], [Question, Answer, Comment, Attachment], user_id: user.id
  end

  def guest_ability
    can [:profiles, :me], User
    can :read, :all
  end

end