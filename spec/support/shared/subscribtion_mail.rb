shared_examples_for "Question Subscribtion Mailing" do
  it 'sends to right email' do
    expect(mail.to).to eq [user.email]
  end
  it 'renders questions' do
    questions.each do |question_ex|
      expect(mail.body.encoded).to match(question_ex.title)
    end
  end
end