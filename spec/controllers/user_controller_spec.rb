RSpec.describe UserController, type: :controller do
  let(:user){create(:user)}
  describe 'PATCH#UPDATE' do
    # sign_in_user
    # before do
    #   Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
    # end
    let(:request) { patch :update, id: user, user: attributes_for(:user, email: "example@email.com") }
    it 'updates user' do
      expect{request}.to change(user, :email)
      expect(user.email).to eq "example@email.com"
    end
  end
end