describe "Question API" do
  context 'unauth' do
      it 'return 401 status if there no auth token' do
        get '/api/v1/questions', format: :json
        expect(response.status).to eq 401
      end

      it 'return 401 status if there auth token invalid' do
        get '/api/v1/questions', format: :json, access_token: "invalid_token"
        expect(response.status).to eq 401
      end
    end
  describe "GET /index" do
    context "authorized" do
    let(:access_token) { create(:access_token) }
    let!(:questions) {create_list(:question, 2)}
    let(:question){ questions.first }
    let!(:answer){ create(:answer, question: question) }
    let(:comments){create_list(:comment, 2, question: question)}
    let(:attachments){create_list(:attachment, 2, question: question)}
    before { get '/api/v1/questions', format: :json, access_token: access_token.token }

    it 'returns 200 status code' do
      expect(response).to be_success
    end

    it 'return questions' do
      expect(response.body).to have_json_size(2)
    end

    %w(id title content created_at updated_at).each do |attr|
      it "question object contains #{attr}" do
        expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
      end
    end

    it 'question contains short title' do
      expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("0/short_title")
    end

    it 'comments included in question object' do
      expect(response.body).to be_json_eql(question.comments.to_json).at_path("0/comments")
    end

    it 'attachments included in question object' do
      expect(response.body).to be_json_eql(question.attachments.to_json).at_path("0/attachments")
    end

    context 'answers' do
      it 'included in question object' do
        expect(response.body).to have_json_size(1).at_path("0/answers")
      end
      %w(id content created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
        end
      end
    end
    end
  end
  describe 'GET /show' do
    let(:access_token) { create(:access_token) }
    let(:question){ create(:question) }
    let(:answers){ create_list(:answer, 2, question: question) }
    let(:comments){create_list(:comment, 2, question: question)}
    let(:attachments){create_list(:attachment, 2, question: question)}
    before { get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token }

    it 'returns 200 status code' do
      expect(response).to be_success
    end

    it 'return questions' do
      expect(response.body).to have_json_size(9)
    end

    %w(id title content created_at updated_at).each do |attr|
      it "question object contains #{attr}" do
        expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("#{attr}")
      end
    end

    it 'question contains short title' do
      expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("short_title")
    end

    it 'comments included in question object' do
      expect(response.body).to be_json_eql(question.comments.to_json).at_path("comments")
    end

    it 'attachments included in question object' do
      expect(response.body).to be_json_eql(question.attachments.to_json).at_path("attachments")
    end

  end

  describe "POST /create" do
    let(:access_token) { create(:access_token) }
    let(:user) { create(:user) }
    let(:request) { post "/api/v1/questions", format: :json, access_token: access_token.token, question: { title:'hi', content:'yo', user: user } }
    it 'creates new question' do
      expect{ request }.to change(Question, :count).by(1)
    end
  end
end