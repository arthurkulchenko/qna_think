require_relative '../acceptance_helper'

feature '', %q(
  To update my answer
  As auth user
  I whant to be able do it
)do
  
  given!(:user){create(:user)}
  given(:another_user){ create(:user) }
  given!(:question){ create(:question, user: user) }
  given!(:answers){ create_list(:answer, 1, question: question, user: user) }

  scenario 'auth user', js: true do
    sign_in(user)
    visit question_path(question)
    find(".button-answer").click
    within '.edit_answer_form' do
      fill_in "Update Form", with: 'Hello Iam Lindsay Lohan'
      click_on 'Update an answer'
    end
    expect(page).to have_content 'Hello Iam Lindsay Lohan'
  end

  scenario 'not owner user' do
    sign_in(another_user)
    visit question_path(question)
    expect(page).to_not have_content 'Edit Answer'
  end

  scenario 'not auth user' do
    visit question_path(question)
    expect(page).to_not have_content 'Edit Answer'
  end
	
end