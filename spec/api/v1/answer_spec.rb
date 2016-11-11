describe "answer API" do

  let(:index_path) { "/api/v1/questions/#{question.id}/answers" }
  let(:show_path) { "/api/v1/answers/#{answer.id}" }
  let(:post_request) { make_post_request index_path, access_token: access_token.token, answer: { question_id: question, content:'yo', user: user } }
  let(:model){ Answer }
  let(:model_instance) { answer }
  
  it_behaves_like "API Authenticable"

end