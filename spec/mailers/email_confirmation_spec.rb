RSpec.describe EmailConfirmationMailer, type: :mailer do
  let(:user){ create(:user) }
  let(:token){ SecureRandom.base64(18).delete('/') }
  let(:mail){ EmailConfirmationMailer.verify_authorization(user, token) }
  it "renders the headers" do
    expect(mail.to).to eq(["user2.2@example.com"])
  end
end