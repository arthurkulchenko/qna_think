RSpec.describe QuestionChangingsJob, type: :job do
  describe "sends mail every time question changing" do

    let(:question){ create(:question)}
    let(:subscribtions){ create_list(:subscribtion, 3, subscribtable: question) }
        
    it "send email every time new answer creates" do
      subscribtions.each do |subscribtion|
        expect(QuestionSubscriptionMailer).to receive(:question_changings_lettering).with(subscribtion.user, question).and_call_original
      end
      question.question_newsletter
    end
  end

end