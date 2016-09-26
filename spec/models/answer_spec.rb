RSpec.describe Answer, type: :model do

  it { should validate_presence_of(:content) }
  it { should belong_to(:user) }
  it { should belong_to(:question) }
  it { should accept_nested_attributes_for :attachments }

  let(:user){ create(:user) }
  let(:question){ create(:question, user: user) }
  let(:not_best_answers){ create_list(:answer, 2, question: question) }
  let(:best_answer){ create(:answer, question: question, best_answer: true) }

  context 'update answers content with BEST:FALSE' do
    it 'should,t change best_answer flag' do
      not_best_answers[0].update(content: 'hello')
      expect(not_best_answers[0].content).to eq 'hello'
      expect(best_answer.best_answer).to eq true
      expect(not_best_answers[0].best_answer).to eq false
    end
  end

  context 'update answers content with BEST:TRUE' do
    it 'should,t change best_answer flag' do
      best_answer.update(content: 'hello')
      expect(best_answer.content).to eq 'hello'
      expect(best_answer.best_answer).to eq true
    end
  end

end