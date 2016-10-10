class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? ( can :manage, :all ) : ( user_ability )
    end
    guest_ability
  end

  def user_ability
    can :vote, [Answer, Question] do |parent|
      !user.is_author_of?(parent)
    end
    can :destroy, Vote, user: user
    can [:create, :update, :destroy], [Question, Answer, Comment, Attachment], user: user
  end

  def guest_ability
    can :read, :all  
  end
end