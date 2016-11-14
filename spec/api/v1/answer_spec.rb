describe "answer API" do

  let(:index_path) { "/api/v1/questions/#{question.id}/answers" }
  let(:show_path) { "/api/v1/answers/#{answer.id}" }
  let(:post_request) { make_post_request index_path, access_token: access_token.token, answer: { question_id: question, content:'yo', user: user } }
  let(:model){ Answer }
  let(:model_instance) { answer }

  let(:user) { create(:user) }
  let(:access_token) { create(:access_token) }
  let!(:questions) {create_list(:question, 2)}
  let(:question){ questions.first }
  let(:answers){ create_list(:answer, 2, question: question) }
  let!(:answer){ create(:answer, question: question) }
  let(:comments){create_list(:comment, 2, question: question)}
  let(:attachments){create_list(:attachment, 2, question: question)}
  
  it_behaves_like "API Authenticable"

end