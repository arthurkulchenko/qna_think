require_relative '../acceptance_helper'

feature 'first answer is the Best', %q(
  To help seeker of solution
  As anyone
  I expect to find best answer in the top
) do
    given(:user){ create(:user) }
    given!(:question){ create(:question) }
    given!(:answers){ create_list(:answer, 3, question_id: question) }
    
    scenario 'The Best answer is on the top', js: true do
      sign_in(user)
      visit question_path(question)

      # fill_in 'Form for Answer', with: 'First'
      # click_on 'Provide an answer'

      # fill_in 'Form for Answer', with: 'Second'
      # click_on 'Provide an answer'
      save_and_open_page
      
      expect(page).to have_content "First"
      expect(page).to have_content "Second"
      expect(page).to have_content "Edit Answer Delete my Answer Second"
    end
end