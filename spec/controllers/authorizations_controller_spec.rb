RSpec.describe AuthorizationsController, type: :controller do

  let(:user){ create(:user) }
  let(:auth){ create(:authorization, user: user, is_confirmed: false, confirmation_token: "QpDyFooGmxlqK2qb4xid42sk") }
  describe 'GET#SHOW' do
    let(:request) { get :show, id: auth.confirmation_token, authorization: attributes_for(:authorization, is_confirmed: true, confirmation_token: nil) }

    it 'should to change auth status' do
      request
      auth.reload
      expect(auth.is_confirmed).to eq true
      expect(auth.confirmation_token).to eq nil
    end
  end

end