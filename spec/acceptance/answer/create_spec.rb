feature 'answer a question', %q(
  In oreder to help someone
  As a registred user
  I want to give an answer
  ) do
    given!(:question){ create(:question)}
    # DO NOT CREATE QUESTION
    given!(:user){ create(:user) }
    background do
      sign_in(user)
      # save_and_open_page
      visit question_path(question)
    end
    
    scenario 'answer apears after its create', js: true do      
      fill_in 'Form for Answer', with: 'Advice'
      click_on 'Provide an answer'
      expect(page).to have_content 'Advice'
    end
end