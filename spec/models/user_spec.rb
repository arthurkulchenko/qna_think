RSpec.describe User, type: :model do
  
  [:questions, :answers, :votes, :comments, :attachments, :authorizations].each do |model|
    it { should have_many(model).dependent(:destroy) }
  end

  let(:user){ create(:user) }
  let(:answer){ create(:answer, user: user) }
  let(:a_answer){ create(:answer) }

  let(:auth){ OmniAuth::AuthHash.new(provider: 'facebook', uid: '123123')}
  let(:method_call){ User.find_for_auth(auth) }

  describe '.find_for_auth method' do
    context 'if user exist in db' do
      context 'if he has authorizations for 3p auth' do
        let!(:authorization){ create(:authorization, user: user, provider: 'facebook', uid: '123123') }
        it 'returns user' do
          expect(method_call).to eq user
        end
      end
      context 'if he has\'t authorizations for 3p auth' do
        let(:auth){ OmniAuth::AuthHash.new(provider: 'facebook', uid: '123123', info: {email: user.email} )}
        it 'returns user' do
          expect(method_call).to eq user
        end
      end
    end
    context 'if user don\'t exist in db' do
      it 'creates User' do
      end
      it 'creates Authorization' do
      end
      it 'returns user' do
        expect(method_call).to eq user
      end
    end
  end

  describe '#is_author_of? method' do  
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

end