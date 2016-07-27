require_relative '../acceptance_helper'

feature '', %q(
  To update my answer
  As auth user
  I whant to be able do it
)do
  
  given(:user){create(:user)}
  given(:another_user){ create(:user) }
  given!(:question){ create(:question) }

  scenario 'auth user', js: true do
    # FAILS WITH
    # Failure/Error: fill_in "Update Form #{question.answers[0].id}", with: 'Hello Iam Lincy Lohan'
    #  Capybara::Ambiguous:
    #    Ambiguous match, found 2 elements matching field "Update Form 1"
    sign_in(user)
    visit question_path(question)

    fill_in 'Form for Answer', with: 'First of all you need ...'\
                    ' and only then ... Best Regards and Good luck!'
    click_on 'Provide an answer'
    expect(page).to have_content 'Edit Answer'
    
    click_on "Edit Answer #{question.answers[0].id}"
    expect(page).to have_content "Update Form #{question.answers[0].id}"
    # save_and_open_page
    fill_in "Update Form #{question.answers[0].id}", with: 'Hello Iam Lindsay Lohan'
    click_on 'Update an answer'
    sleep 900
    expect(page).to have_content 'Hello Iam Lincy Lohan'

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