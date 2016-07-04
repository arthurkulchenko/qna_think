require_relative '../acceptance_helper'

feature 'showing question', %q(
  In order to familiarize with ditails of question
  As a reqular user
  I want to see a current question and it's answers
  ) do
    given(:question) { create(:question) }
    given(:answers){ create_list(:answer, 3, question: question) }
    scenario 'show question' do
      visit question_path(question)
      expect(page).to have_content question.title
      expect(page).to have_content question.content
      expect(page).to have_content 'Share you experiance and wisdom'
    end
    scenario 'listing answers' do
      expect(page).to have_content question.answers[0].content
      question.answers.each do |answer| 
        # expect(page).to have_content answer.content
      end
    end
  end