require_relative '../acceptance_helper'

feature 'answer a question', %q(
  In oreder to help someone
  As a registred user
  I want to give an answer
  ) do

    given(:question){ create(:question)  }
    given(:user){ create(:user) }
    background do
      sign_in(user)
      visit question_path(question)
      # click_on 'Offer solution'
      fill_in 'Form for Answer', with: 'First of all you need ...'\
                    ' and only then ... Best Regards and Good luck!'
      click_on 'Provide an answer'
    end
    
    scenario 'giving an answer', js: true do
      expect(page).to have_content 'First of all you need ...'\
                    ' and only then ... Best Regards and Good luck!'
    end
    
    scenario 'answer apears after its create', js: true do
      expect(page).to have_content 'First of all you need ...'\
                  ' and only then ... Best Regards and Good luck!'
    end
end