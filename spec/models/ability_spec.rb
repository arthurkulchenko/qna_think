describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'user' do
    let(:user){ create(:user, admin: false) }
    let(:other){ create(:user, admin: false) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    [:question, :answer, :comment, :vote].each do |resource|
      it { should be_able_to :create, resource.to_s.classify.constantize }
      it { should be_able_to :update, create(resource ,user: user), user: user }
      
      it { should_not be_able_to :update, create(resource ,user: other), user: user }
    end
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