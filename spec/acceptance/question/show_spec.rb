require_relative '../acceptance_helper'

feature 'showing question', %q(
  In order to familiarize with ditails of question
  As a reqular user
  I want to see a current question and it's answers
  ) do
    
    given!(:question) { create(:question) }
    given!(:answers){ create_list(:answer, 3, question: question) }
    background { visit question_path(question) }

    scenario 'show question' do
      %Q(#{question.title} #{question.content})
              .split.each{ |i| expect(page).to have_content i }
    end

  end