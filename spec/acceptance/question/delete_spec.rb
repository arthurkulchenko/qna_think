require_relative '../acceptance_helper'

feature 'deleting question', %q(
In order to delete question
As a auth user
I want to delete my own question
)do
  given!(:user) { create(:user) }
  given(:one_more_user) { create(:user) }
  given(:question){ create(:question, user: user) }
  given(:answers){ create_list(:answer, 3, question: question) }
  
  scenario '***********only owner can delete question', js: true do
    sign_in(user)
    visit question_path(question)
    find(".button").click
    click_on 'Delete my Question'
    visit questions_path
    expect(page).to_not have_content question.content
  end
  
  scenario '***********another auth user cant delete alian question', js: true do
    sign_in(one_more_user)
    visit question_path(question)
    expect(page).to_not have_content 'Delete my Question'
  end

  scenario '***********not auth user cant delete alian question', js: true do
    visit question_path(question)
    expect(page).to_not have_content 'Delete my Question'
  end
end