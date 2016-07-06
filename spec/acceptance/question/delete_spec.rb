require_relative '../acceptance_helper'

feature 'deleting question', %q(
In order to delete question
As a auth user
I want to delete my own question
)do
  given(:user) { create(:user) }
  given(:question){ create(:question, user: user) }
  scenario 'only owner can delete question' do
    visit question_path(question)
    click_on 'Delete my Question'
    visit question_index_path
    expect(page).to not_have_content question.content
  end
end