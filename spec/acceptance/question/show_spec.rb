require_relative '../acceptance_helper'

feature 'showing question', %q(
  In order to familiarize with ditails of question
  As a reqular user
  I want to see a current question and it's answers
  ) do
    
    given!(:question) { create(:question) }
    given!(:answers){ create_list(:answer, 3, question: question) }
    # given!(:answer) { create(:answer, question: question) }

    background { visit question_path(question) }

    scenario 'show question' do
      %Q(#{question.title} #{question.content} Offer\ solution)
              .split.each{ |i| expect(page).to have_content i }
    end
    scenario 'listing answers' do
      save_and_open_page
      # expect(page).to have_content answer.content

      answers.each { |a| expect(page).to have_content a.content }
    end    
  end