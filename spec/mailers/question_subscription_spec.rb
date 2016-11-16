RSpec.describe QuestionSubscriptionMailer, type: :mailer do
  let(:user){ create(:user, subscibe_on_digest: true) }
  let(:questions){ create_list(:question, 3, created_at: DateTime.yesterday) }
  let(:digest_mail){ QuestionSubscriptionMailer.send_digest(user, questions) }
  let(:question_subscription){ QuestionSubscriptionMailer. }
  
  it 'sends to right email' do
    expect(digest_mail.to).to eq [user.email]
  end

  it 'renders questions' do
    questions.each do |question|
      expect(digest_mail.body.encoded).to match(question.title)
    end
  end
end
