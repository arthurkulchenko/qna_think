RSpec.describe Vote, type: :model do
  it { should belong_to(:user) }
  it { validate_inclusion_of(:mark) }

  let(:user){create(:user)}
  let(:user2){create(:user)}
  let(:question){create(:question, user: user2)}
  let(:answer){create(:answer, user: user2, question: question)}
  let(:vote1){create(:vote, user: user, ballot: question, mark: 1)}
  let(:vote2){create(:vote, user: user, ballot: answer, mark: 1)}
  
  context 'with question' do
    it 'updates parent\'s mark' do
      expect{vote1.delete}.to change(question, :mark)
    end
  end
  context 'with answer' do
    it 'updates parent\'s mark' do
      expect{vote2.delete}.to change(answer, :mark)
    end
  end

  context 'with question' do
    it 'deletes same users vote' do
      expect{Vote.create(ballot: question, mark: -1)}.to change(question, :mark).to(-1)
    end
  end
  context 'with answer' do
    it 'deletes same users vote' do
      expect{Vote.create(ballot: answer, mark: -1)}.to change(answer, :mark).to(-1)
    end
  end
end