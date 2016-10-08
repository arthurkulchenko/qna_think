RSpec.describe EmailConfirmationMailer, type: :mailer do
  let(:user){create(:user)}
  let(:mail){ EmailConfirmationMailer.verify_authorization }
  it "renders the headers" do
    expect(mail.to).to eq(["to@example.org"])
  end
end