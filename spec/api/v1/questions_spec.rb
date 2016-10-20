describe "Question API" do
  describe "GET /index" do
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

    context "authorized" do
      let(:access_token) { create(:access_token) }
      let!(:questions) {create_list(:question, 2)}
      let(:question){ questions.first }
      let!(:answer){ create(:answer, question: question) }
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

      it  'question contains short title' do
        expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("0/short_title")
      end

      context 'answers' do
      it 'included in question object' do
        expect(response.body).to have_json_size(1).at_path("0/answers")
      end
      %w(id question_id content created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
        end
      end
    end
    end
  end
end