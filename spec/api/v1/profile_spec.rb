describe 'Profile API' do
  let(:me){ create(:user) }
  let(:some){ create(:user) }
  let(:access_token){ create(:access_token, resource_owner_id: me.id) }
  let(:me_path){'/api/v1/profiles/me'}
  let(:index_path){'/api/v1/profiles'}

  context 'unauth' do
    it 'return 401 status if there no auth token' do
      make_get_request me_path
      expect(response.status).to eq 401
    end
    it 'return 401 status if there auth token invalid' do
      make_get_request me_path, access_token: "invalid_token"
      expect(response.status).to eq 401
    end
  end

  context 'unauth' do
    it 'return 401 status if there no auth token' do
      make_get_request index_path
      expect(response.status).to eq 401
    end
    it 'return 401 status if there auth token invalid' do
      make_get_request index_path, access_token: "invalid_token"
      expect(response.status).to eq 401
    end
  end
  
  describe 'GET /me' do

      before { make_get_request me_path, access_token: access_token.token }
      it_behaves_like "Success status"

      %w(email id created_at updated_at admin email_real).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end
      %w(password encrypted_password).each do |attr|
        it "does not contains #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end

  end

  describe 'GET /index' do
      
    before { make_get_request index_path, access_token: access_token.token }
    it_behaves_like "Success status"
    %w(password encrypted_password).each do |attr|
      it "does not contains #{attr}" do
        expect(response.body).to_not have_json_path(attr)
      end
    end
  end

  def make_get_request path, options = {}
    get path, { format: :json }.merge(options)
  end
end