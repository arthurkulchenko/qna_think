require_relative '../acceptance_helper'

feature 'answer voting', %q(
  To deside which answer is important
  As regular registred user
  I wish to be able to vote for it
) do
    given(:user){ create(:user) }
    given(:question){ create(:question) }
    given!(:answer){ create(:answer, question: question) }
    given!(:user_answer){ create(:answer, user: user, question: question) }

    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario "owner of answer can't vote for his answer" do
      expect(page).to_not have_content "Total mark is: 1"
    end

    scenario "voice is considered", js: true do
      page.execute_script("$('#Answers-rate').click()")
      page.execute_script("$('#Answers-rate').parent().submit()")
      expect(page).to have_content "Total mark is: 1"
    end
end