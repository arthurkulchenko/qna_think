RSpec.describe User, :type => :model do
  
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }

  let(:user){ create(:user) }
  let(:answer){ create(:answer, user: user) }
  let(:a_answer){ create(:answer) }
  
  context 'success' do
    it 'checks is_author_of? method' do
      expect(user.is_author_of?(answer)).to eq true
    end
  end
  context 'fail' do
    it 'checks is_author_of? method' do
      expect(user.is_author_of?(a_answer)).to eq false
    end
  end
end