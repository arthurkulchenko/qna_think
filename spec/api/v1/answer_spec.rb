describe "answer API" do
  describe "GET /index" do
    let(:question){ create(:question) }
    context 'unauth' do
      it 'return 401 status if there no auth token' do
        get "/api/v1/questions/#{question.id}/answers", format: :json
        expect(response.status).to eq 401
      end

      it 'return 401 status if there auth token invalid' do
        get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: "invalid_token"
        expect(response.status).to eq 401
      end
    end

    context "authorized" do
      let(:access_token) { create(:access_token) }
      let!(:answers) {create_list(:answer, 2, question: question)}
      let(:answer){ answers.first }
      let(:comments) { create(:comment, 2, answer: answer) }
      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'return answers' do
        expect(response.body).to have_json_size(2)
      end

      %w(id content created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      context 'comments' do
        it 'included in answer object' do
          expect(response.body).to have_json_size(6).at_path("0")
        end

          it "comment object contained" do
            expect(response.body).to be_json_eql(answer.comments.to_json).at_path("0/comments")
          end
  
      end
    end

  describe 'GET /show' do
    let(:access_token) { create(:access_token) }
    let(:answer){ create(:answer, question: question) }
    let(:comments){create_list(:comment, 2, answer: answer)}
    let(:attachments){create_list(:attachment, 2, answer: answer)}
    before { get "/api/v1/answers/#{answer.id}", format: :json, access_token: access_token.token }

    it 'returns 200 status code' do
      expect(response).to be_success
    end

    it 'return questions' do
      expect(response.body).to have_json_size(6)
    end

    %w(id content created_at updated_at).each do |attr|
      it "answer object contains #{attr}" do
        expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("#{attr}")
      end
    end

    it 'comments included in answer object' do
      expect(response.body).to be_json_eql(answer.comments.to_json).at_path("comments")
    end

    it 'attachments included in answer object' do
      expect(response.body).to be_json_eql(answer.attachments.to_json).at_path("attachments")
    end

  end

  describe "POST /create" do
    let(:access_token) { create(:access_token) }
    let(:user) { create(:user) }
    let(:request) { post "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token, answer: { question_id: question, content:'yo', user: user } }
    it 'creates new question' do
      expect{ request }.to change(Answer, :count).by(1)
    end
  end
  end
end