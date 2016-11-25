RSpec.describe User, type: :model do
  
  [:questions, :answers, :votes, :comments, :attachments, :authorizations].each do |model|
    it { should have_many(model).dependent(:delete_all) }
  end

  let(:user){ create(:user) }
  let(:answer){ create(:answer, user: user) }
  let(:a_answer){ create(:answer) }

  let(:auth){ OmniAuth::AuthHash.new(provider: 'facebook', uid: '123123')}
  let(:method_call){ User.find_for_oauth(auth) }

  describe '.find_by_auth method' do
    context 'if user exist in db' do
      context 'if he has authorizations for 3p auth' do
        let!(:authorization){ create(:authorization, user: user, provider: 'facebook', uid: '123123') }
        it 'returns user' do
          expect(method_call).to eq user
        end
      end
      context 'if he has\'t authorizations for 3p auth' do
        context 'email given' do
          let!(:user){ create(:user) }
          let(:auth){ OmniAuth::AuthHash.new(provider: 'facebook', uid: '123123', info: {email: user.email} )}
          it 'returns user' do
            expect(method_call).to eq user
          end
        end
      end
    end
    context 'if user don\'t exist in db' do
      context 'email given' do
        let(:auth){ OmniAuth::AuthHash.new(provider: 'facebook', uid: '123123', info: {email: user.email} )}
        it 'creates User' do
          expect{method_call}.to change(User, :count).by(1)
        end
        it 'creates Authorization' do
          expect{method_call}.to change(Authorization, :count).by(1)
        end
        it 'returns user' do
          expect(method_call).to eq user
        end
      end
      context 'email don\'t given' do
        let(:auth){ OmniAuth::AuthHash.new(provider: 'facebook', uid: '1231234', info: {}) }
        let(:method_call){ User.find_for_oauth(auth) }
        let(:time){ Time.now }
        let(:id){User.last.id}
        it 'creates User' do
          expect{method_call}.to change(User, :count).by(1)
        end
        it 'creates Authorization' do
          expect{method_call}.to change(Authorization, :count).by(1)
        end
        it 'returns user' do
          expect(method_call).to eq User.new(email: 'facebook-1231234@email.com', id: id, created_at: time, updated_at: time)
        end
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

  # describe '.sending_digest_newsletter' do
  #   let(:users){create_list(:user, 2, subscibe_on_digest: true)}
  #   let(:questions){ create_list(:question, 3, created_at: DateTime.yesterday) }
  #   it 'sends maill' do
  #     users.each { |user| expect(QuestionSubscriptionMailer).to receive(:send_digest).with(user, questions).and_call_original }
  #     User.sending_digest_newsletter
  #   end
  # end

end