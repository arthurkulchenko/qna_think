RSpec.describe Vote, type: :model do
  it_behaves_like "User Belongings"
  it { should validate_inclusion_of(:mark).in_array([-1,0,1]) }

  let(:user){create(:user)}
  let(:user2){create(:user)}
  let(:question){create(:question, user: user2)}
  let(:answer){create(:answer, user: user2, question: question)}
  let(:vote1){create(:vote, user: user, ballot: question, mark: 1)}
  let(:vote2){create(:vote, user: user, ballot: answer, mark: 1)}
  subject { build(:vote, ballot: question) }
  let(:new_vote) { create(:voted_plus, ballot: question) }

  context 'mokking' do
    it 'method updates parents mark sum' do
      expect(subject).to receive(:update_mark_sum)
      subject.save
    end
    it 'method do not updates parents mark sum' do
      subject.save
      expect(subject).to_not receive(:update_mark_sum)
      subject.update(mark: -1)
    end
    it "returns mark" do
      allow(new_vote).to receive(:update_mark_sum).and_return(1)
      expect{ create(:voted_plus, ballot: question) }.to change(question, :mark).by(1)
    end
  end
  
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
      expect{Vote.create(ballot: question, mark: -1, user: user)}.to change(question, :mark).to(-1)
    end
  end
  context 'with answer' do
    it 'deletes same users vote' do
      expect{Vote.create(ballot: answer, mark: -1, user: user)}.to change(answer, :mark).to(-1)
    end
  end
end