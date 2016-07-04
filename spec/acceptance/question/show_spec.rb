require_relative '../acceptance_helper'

feature 'showing question', %q(
  In order to familiarize with ditails of question
  As a reqular user
  I want to see a current question
  ) do
    given!(:question) { create(:question) }
    scenario 'show question' do
      visit question_path(question)
      expect(page).to have_content question.title
      expect(page).to have_content question.content
    end
  end