RSpec.describe "SetEmail", type: :request do
  describe "UPDATE /set_email/:id(users)" do
    let(:user){ create(:user) }
    it "updates user email" do
      headers = { "CONTENT_TYPE" => "application/json" }
      patch "/set_emails/#{user.id}", '{ "user": {"email":"example@email.com"}}', headers
      expect(response).to have_http_status(302)
    end
  end
end