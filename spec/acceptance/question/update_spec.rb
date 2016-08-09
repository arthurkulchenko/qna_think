require_relative '../acceptance_helper'

feature '', %q(
  To update my question
  As auth user
  I want to be able do it
)do
  given(:user){create(:user)}
  given(:another_user){ create(:user) }
  given!(:question){ create(:question, user: user) }
  given!(:answers){ create_list(:answer, 3, question: question) }

  scenario 'auth user', js: true do
    sign_in(user)
    visit question_path(question)
    # click_on "Edit Question"
    within '.edit_question_form' do
      fill_in "Update Form", with: 'Its corrected question'
      click_on 'Update a question'
    end
    expect(page).to have_content 'Its corrected question'
  end

  scenario 'not owner user' do
    sign_in(another_user)
    visit question_path(question)
    expect(page).to_not have_content 'Edit question'
  end

  scenario 'not auth user' do
    visit question_path(question)
    expect(page).to_not have_content 'Edit question'
  end
	
end