require_relative '../acceptance_helper'

feature '', %q(
  To update my answer
  As auth user
  I whant to be able do it
)do
  
  given(:user){create(:user)}
  given(:another_user){ create(:user) }
  given!(:question){ create(:question, user: user) }
  given!(:answers){ create_list(:answer, 3, question: question) }


  scenario 'question owner choose best answer', js: true do
    sign_in(user)
    visit question_path(question)
    
    fill_in 'Form for Answer', with: 'First'
    click_on 'Provide an answer'
      
      visit question_path(question)
      check('Is this Answer The Best?')
    save_and_open_page
    within '.answers' do
      fill_in 'Form for Answer', with: 'second'
      
      click_on 'Provide an answer'
    end
    
    # expect(page).to have_content "Question Answers #{question.answers[0].content}"
    

    # expect(page).to have_content 


  end

  scenario 'auth user', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Form for Answer', with: 'First of all you need ...'\
                    ' and only then ... Best Regards and Good luck!'
    click_on 'Provide an answer'
    # click_on "Edit Answer"
    within '.answers' do
      fill_in "Update Form", with: 'Hello Iam Lindsay Lohan'
      click_on 'Update an answer'
      expect(page).to have_content 'Hello Iam Lindsay Lohan'
    end
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