RSpec.describe "Authorization", type: :request do
  describe "SHOW /authorization/:confirmation_token" do
    let(:user){ create(:user) }
    let(:authorization){ create(:authorization, user: user) }
    it "updates user email" do
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/authorizations/#{authorization.confirmation_token}", '{ "authorization": {"is_confirmed":"true", "confirmation_token":"nil"}}', headers
      expect(response).to have_http_status(302)
    end
  end
end