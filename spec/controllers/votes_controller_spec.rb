RSpec.describe VotesController, type: :controller do
  let(:user){ create(:user) }
  let(:user2){ create(:user) }
  let(:question){ create(:question, user: user2) }
  let(:vote){ create(:vote, user: user, ballot: question) }

  describe 'POST#CREATE' do
    sign_in_user
    context 'success with question' do
      let(:request) { post :create, id: :vote, question_id: question, vote: attributes_for(:voted_plus), format: :json }
      it 'adds new vote' do
        expect{ request }.to change(Vote, :count).by(1)
      end
      it 'relate vote with its user' do
        request
        expect(assigns(:vote).user).to eq @user
      end
    end
    context 'fail with question' do
      let(:request) { post :create, id: :vote, question_id: question, vote: attributes_for(:illigal_voted), format: :json }
      it 'do not adds new vote' do
        expect{ request }.to_not change(Vote, :count)
      end
    end
  end
  describe 'DESTROY#DELETE' do
    context "success deletation" do
      sign_in_user
      let(:user){ subject.current_user }
      let(:request) { delete :destroy, id: vote, format: :json }
      it 'deletes vote' do
        vote
        expect{ request }.to change(Vote, :count).by(-1)
      end
    end
    context "failed deletation" do
      sign_in_user
      let(:request) { delete :destroy, id: vote, format: :json }
      it 'do not deletes vote' do
        vote
        expect{ request }.to_not change(Vote, :count)
      end
    end
  end

end
