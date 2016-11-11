shared_examples_for "API Authenticable" do
  let(:user) { create(:user) }
  let(:access_token) { create(:access_token) }
  let!(:questions) {create_list(:question, 2)}
  let(:question){ questions.first }
  let(:answers){ create_list(:answer, 2, question: question) }
  let!(:answer){ create(:answer, question: question) }
  let(:comments){create_list(:comment, 2, question: question)}
  let(:attachments){create_list(:attachment, 2, question: question)}

  context 'unauth' do
    it 'return 401 status if there no auth token' do
      make_get_request(index_path, access_token: nil)
      expect(response.status).to eq 401
    end
    it 'return 401 status if there auth token invalid' do
      make_get_request(index_path, access_token: "invalid_token")
      expect(response.status).to eq 401
    end
  end
  context 'authorized' do
    before { make_get_request index_path, access_token: access_token.token }

    describe 'GET #index' do

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it "comment object contained" do
        expect(response.body).to be_json_eql(model_instance.comments.to_json).at_path("0/comments")
      end

      it 'attachments included in question object' do
        expect(response.body).to be_json_eql(model_instance.attachments.to_json).at_path("0/attachments")
      end

      %w(id content created_at updated_at).each do |attr|
        it "model_instance object contains #{attr}" do
          expect(response.body).to be_json_eql(model_instance.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

    end

    describe "GET show" do
      before { make_get_request show_path, access_token: access_token.token }
      it 'returns 200 status code' do
        expect(response).to be_success
      end

      %w(id content created_at updated_at).each do |attr|
        it "model_instance object contains #{attr}" do
          expect(response.body).to be_json_eql(model_instance.send(attr.to_sym).to_json).at_path("#{attr}")
        end
      end

    it 'comments included in model_instance object' do
      expect(response.body).to be_json_eql(model_instance.comments.to_json).at_path("comments")
    end

    it 'attachments included in model_instance object' do
      expect(response.body).to be_json_eql(model_instance.attachments.to_json).at_path("attachments")
    end
    end

    describe "POST /create" do
    
      it 'creates new model_instance' do
        expect{ post_request }.to change(model, :count).by(1)
      end
    end
 
  end
  def make_post_request path, options = {}
    post path, { format: :json }.merge(options)
  end

  def make_get_request path, options = {}
    get path, { format: :json }.merge(options)
  end
end