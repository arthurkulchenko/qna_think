shared_examples_for "API Unauth" do
  context 'unauth' do
    before { make_get_request path, access_token: nil }
    it 'return 401 status if there no auth token' do
      make_get_request path, access_token: nil
      expect(response.status).to eq 401
    end
  end
  context 'wrong token' do
    before { make_get_request path, access_token: "nil" }
    it 'return 401 status if there auth token invalid' do
      make_get_request path, access_token: "invalid_token"
      expect(response.status).to eq 401
    end
  end
end