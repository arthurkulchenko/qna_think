describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'user' do
    let(:user){ create(:user, admin: false) }
    let(:vote_owner){ create(:user, admin: false) }
    let(:question_owner){ create(:user, admin: false) }
    let(:question){ create(:question, user: question_owner) }
    let!(:vote){ create(:vote, user: user, ballot: question)}
    let(:stranger){ create(:user, admin: true) }

    
    let(:question2){ create(:question, user: vote_owner) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }
    
    [:question, :answer, :comment, :attachment].each do |resource|
      it { should be_able_to :create, resource.to_s.classify.constantize }
      it { should be_able_to :update, create(resource, user: user), user: user }
      it { should be_able_to :delete, create(resource, user: user), user: user }
      it { should_not be_able_to :update, create(resource, user: vote_owner), user: user }
      it { should_not be_able_to :delete, create(resource, user: vote_owner), user: user }
    end
    
    it { should_not be_able_to :create, vote, user: question_owner }
    it { should be_able_to :create, Vote, user: user unless question.user }

    it { should be_able_to :destroy, vote, user: user }
  end

  describe 'admin' do
    let(:user){ create(:user, admin: true) }
    it { should be_able_to :manage, :all }
  end

  describe 'guest' do
    let(:user){nil}

    [Question, Answer, Comment, Vote].each do |resource|
      it { should be_able_to :read, resource}
    end

    it { should_not be_able_to :manage, :all }
  end
end