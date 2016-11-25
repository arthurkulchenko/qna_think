RSpec.describe NewAnswerLetteringJob, type: :job do
  describe " new answer lettering" do
    let(:answer){ create(:answer)}
        
    it "send email every time new answer creates" do
      expect(QuestionSubscriptionMailer).to receive(:new_answer_letter).with(answer.question.user, answer).and_call_original
      NewAnswerLetteringJob.perform_now(answer)
    end

  end
end