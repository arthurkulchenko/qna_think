require_relative '../acceptance_helper'

feature 'listing of all answer wich '\
'is belongs to current questin', %q(
  In order to search of solution in a resolved issue
  As a regular user
  I want to see list of answers
  ) do
    given(:question){ create(:question) }
    given(:answers){ create_list(:answer, 3, question: question) }
    background { visit question_path(question) }
    
    scenario 'listing answers' do
      question.answers.each { |a| expect(page).to have_content a.content }
    end
end