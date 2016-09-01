require_relative '../acceptance_helper'

feature 'first answer is the Best', %q(
  To help seeker of solution
  As anyone
  I expect to find best answer in the top
) do
    given(:user){ create(:user) }
    given!(:question){ create(:question) }
    given!(:answers){ create_list(:answer, 3, question: question) }
    
    scenario 'The Best answer is on the top', js: true do
      sign_in(user)
      visit question_path(question)
      # save_and_open_page
      expect(page).to have_content "sequenced content -- 3 Total rate is 0 Good Bad Attached" \
      " files sequenced content -- 1"
    end
end