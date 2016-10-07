describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'user' do
    let(:user){ create(:user, admin: false) }
    let(:vote_owner){ create(:user, admin: false) }
    let(:question_owner){ create(:user, admin: false) }
    let(:question){ create(:question, user: question_owner) }
    
    let(:question2){ create(:question, user: vote_owner) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }
# , :attachment
    [:question, :answer, :comment].each do |resource|
      it { should be_able_to :create, resource.to_s.classify.constantize }
      it { should be_able_to :update, create(resource, user: user), user: user }
      it { should be_able_to :delete, create(resource, user: user), user: user }
      it { should_not be_able_to :update, create(resource, user: vote_owner), user: user }
      it { should_not be_able_to :delete, create(resource, user: vote_owner), user: user }
    end


    it { should be_able_to :create, create(:vote, user: user, ballot: question), user: !vote_owner }
    it { should_not be_able_to :create, create(:vote, user: user, ballot: question), user: vote_owner }
    it { should be_able_to :delete, create(:vote, user: user, ballot: question), user: vote_owner }
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