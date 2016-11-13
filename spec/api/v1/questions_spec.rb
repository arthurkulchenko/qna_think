describe "Question API" do
  let(:access_token) { create(:access_token) }
  let(:model){ Question }
  let!(:questions) {create_list(:question, 2)}
  let(:question){ questions.first }
  let(:model_instance) { question}
  let(:index_path){'/api/v1/questions'}
  let(:show_path){"/api/v1/questions/#{question.id}"}
  let(:post_request){make_post_request index_path, access_token: access_token.token, question: { title:'hi', content:'yo', user: user }}

  let(:user) { create(:user) }
  let(:access_token) { create(:access_token) }
  let!(:questions) {create_list(:question, 2)}
  let(:question){ questions.first }
  let(:answers){ create_list(:answer, 2, question: question) }
  let!(:answer){ create(:answer, question: question) }
  let(:comments){create_list(:comment, 2, question: question)}
  let(:attachments){create_list(:attachment, 2, question: question)}
  
  it_behaves_like "API Authenticable"

  describe "GET /index" do

    before { make_get_request index_path, access_token: access_token.token }
    it 'question contains title' do
      expect(response.body).to be_json_eql(model_instance.title.to_json).at_path("0/title")
    end
      it 'question contains short title' do
      expect(response.body).to be_json_eql(model_instance.title.truncate(10).to_json).at_path("0/short_title")
    end
  end
  describe 'GET /show' do
    
    before { make_get_request show_path, access_token: access_token.token }
    it 'question contains title' do
      expect(response.body).to be_json_eql(model_instance.title.to_json).at_path("title")
    end
    it 'question contains short title' do
      expect(response.body).to be_json_eql(model_instance.title.truncate(10).to_json).at_path("short_title")
    end
  end

  def make_get_request path, options = {}
    get path, { format: :json }.merge(options)
  end
end