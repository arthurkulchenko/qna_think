require_relative '../acceptance_helper'

feature 'delete answer', %q(
  In order to delete answer
  As auth user
  I want to delete my own answer
  )do
    given!(:user){ create(:user) }
    given(:another_user){ create(:user) }
    given!(:question){ create(:question, user: user) }
    given!(:answer){ create(:answer, question: question, user: user) }
    
    scenario 'deleting answer', js: true do
      sign_in(user)
      visit question_path(question)
      find(".button-answer").click
      click_on 'Delete my Answer'
      expect(page).to_not have_content answer.content
    end

    scenario 'sign_in deleteing answer', js: true do
      sign_in(another_user)
      visit question_path(question)
      expect(page).to_not have_content 'Delete my Answer'
      expect(page).to have_content answer.content
    end

    scenario 'not sign_in deleteing answer', js: true do
      visit question_path(question)
      expect(page).to_not have_content 'Delete my Answer'
      expect(page).to have_content answer.content
    end

end