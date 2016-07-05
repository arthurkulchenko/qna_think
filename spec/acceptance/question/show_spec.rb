require_relative '../acceptance_helper'


feature 'showing question', %q(
  In order to familiarize with ditails of question
  As a reqular user
  I want to see a current question and it's answers
  ) do
    background { visit question_path(question) }
    given!(:question) { create(:question) }
    let(:answers){ create_list(:answer, 3, question: question) }
    scenario 'show question' do
      %Q(#{question.title} #{question.content} Share\ your\ experiance\ and\ wisdom)
              .split.each{|i| expect(page).to have_content i }
    end
    scenario 'listing answers' do
      question.answers.each do |answer|
        expect(page).to have_content answer.content
      end
      # save_and_open_page
    end
  end