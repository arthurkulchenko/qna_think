require_relative '../acceptance_helper'

feature '', %q(
  To update my question
  As auth user
  I whant to be able do it
)do
  given(:user){create(:user)}
  given(:another_user){ create(:user) }
  given(:question){ create(:question) }

  scenario 'auth user' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content 'Edit question'
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