RSpec.describe QuestionSubscriptionMailer, type: :mailer do
  let(:user){ create(:user, subscibe_on_digest: true) }
  let(:questions){ create_list(:question, 3, created_at: DateTime.yesterday) }
  let(:digest_mail){ QuestionSubscriptionMailer.send_digest(user, questions) }
  let(:question_subscription){ QuestionSubscriptionMailer.question_changings_lettering(user, questions.first) }
  
  context 'digest' do
    let(:mail){digest_mail}
    it_behaves_like "Question Subscribtion Mailing"
  end
  context 'question subscribtion' do
    let(:mail){question_subscription}
    it_behaves_like "Question Subscribtion Mailing"
  end
end
