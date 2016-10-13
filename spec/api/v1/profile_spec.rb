describe 'Profile API' do
  describe 'GET /me' do
    context 'unauth' do
      it 'return 401 status if there no auth token' do
        get '/api/v1/profiles/me', format: :json
        expect(response.status).to eq 401
      end

      it 'return 401 status if there auth token invalid' do
        get '/api/v1/profiles/me', format: :json, access_token: "invalid_token"
        expect(response.status).to eq 401
      end
    end

    context 'auhtorized' do
      let(:me){ create(:user) }
      let(:access_token){ create(:access_token, resource_owner_id: me.id) }
      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it 'return 200 status' do
        expect(response).to be_success
      end

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
  end

  describe 'GET /all' do
    context 'unauth' do
      it 'return 401 status if there no auth token' do
        get '/api/v1/profiles/all', format: :json
        expect(response.status).to eq 401
      end

      it 'return 401 status if there auth token invalid' do
        get '/api/v1/profiles/all', format: :json, access_token: "invalid_token"
        expect(response.status).to eq 401
      end
    end

    context 'auhtorized' do
      let(:all){ create(:user) }
      let(:access_token){ create(:access_token, resource_owner_id: all.id) }
      before { get '/api/v1/profiles/all', format: :json, access_token: access_token.token }

      it 'return 200 status' do
        expect(response).to be_success
      end

      # %w(email id created_at updated_at admin email_real).each do |attr|
      #   it "contains #{attr}" do
      #     response.body.to_json.each do |i|
      #       expect(i).to be_json_eql(all.send(attr.to_sym).to_json).at_path(attr)
      #     end
      #   end
      # end

      %w(password encrypted_password).each do |attr|
        it "does not contains #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end

    end
  end
end