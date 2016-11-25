RSpec.describe DigestLetteringJob, type: :job do
  describe "Digest mailing" do
    let(:users){create_list(:user, 2, subscibe_on_digest: true)}
    let(:questions){ create_list(:question, 3, created_at: DateTime.yesterday) }
    
    it "send mail" do
      users.each { |user| expect(QuestionSubscriptionMailer).to receive(:send_digest).with(user, questions).and_call_original }
      User.sending_digest_newsletter
    end
  end
end