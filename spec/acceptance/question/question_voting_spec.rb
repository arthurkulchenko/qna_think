require_relative '../acceptance_helper'

feature 'question voting', %q(
  To deside which question is important
  As regular registred user
  I wish to be able to vote for it
) do
    given(:user){ create(:user) }
    given(:question){ create(:question) }
    given(:user_question){ create(:question, user: user) }
    background{ sign_in(user) }

    scenario "owner of question can't vote for his question" do
      visit question_path(user_question)
      expect(page).to_not have_button "Rate Question"
    end

    scenario "not owner of question can rate question" do
      visit question_path(question)
      expect(page).to have_button "Rate Question"
    end

    scenario "voice is considered", js: true do
      visit question_path(question)
      # choose "Good", visible: false # не может найти элемент
      page.execute_script("document.getElementById('Questions-rate').checked = true")
      click_on 'Rate Question'
      expect(page).to have_content "Total mark is: 1"
    end
end