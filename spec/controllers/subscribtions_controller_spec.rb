RSpec.describe SubscribtionsController, type: :controller do
  let(:user){ create(:user) }
  let!(:question){ create(:question) }
  let!(:subscribtion){ create(:subscribtion, user: user, subscribtable: question) }
  sign_in_user
#---------------------------------------CREATE
  describe "POST#create" do
    let(:request){ post :create, question_id: question, subscribtion: attributes_for(:subscribtion), format: :json }
    it 'creates new subscribtion' do
      expect{ request }.to change(Subscribtion, :count).by(1)
    end
  end
#---------------------------------------DESTROY
  describe "DELETE#destroy" do
    let(:request){ delete :destroy, id: subscribtion, format: :json }
    it 'deletes sub...' do
      expect{ request }.to change(Subscribtion, :count).by(-1)
    end
  end
end