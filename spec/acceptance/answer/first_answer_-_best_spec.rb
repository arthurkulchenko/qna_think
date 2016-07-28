require_relative '../acceptance_helper'

feature 'first answer is the Best', %q(
  To help seeker of solution
  As anyone
  I expect to find best answer in the top
) do
   
    given(:question){ create(:question) }
    given(:answers){ create_list(:answer, 3, question_id: question) }
    
    scenario 'The Best answer is on the top' do
      visit question_path(question)
      expect(page).to have_content "#{question.answers[0].content}"
    end
end