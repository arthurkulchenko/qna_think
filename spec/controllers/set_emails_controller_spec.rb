RSpec.describe SetEmailsController, type: :controller do
  let(:user){ create(:user, email_confirmation_token: token) }
  describe 'PATCH#UPDATE' do
    let(:request) { patch :update, id: user, user: attributes_for(:user, email: "example@email.com") }

    it 'should to change users email' do
      request
      user.reload
      expect(user.email).to eq "example@email.com"
    end
  end
end