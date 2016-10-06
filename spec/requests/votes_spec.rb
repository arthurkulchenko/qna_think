RSpec.describe "Votes", type: :request do
  describe "POST /votes" do
    let(:user){ create(:user) }
    let(:question){ create(:question) }
    let(:answer){ create(:answer, question: question) }
    let(:vote){ create(:vote, user: user, answer: answer) }
    it "posts" do
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/answers/#{answer.id}/votes", '{ "vote": { "mark":"1" } }', headers
      expect(response).to have_http_status(201)
    end
  end
end