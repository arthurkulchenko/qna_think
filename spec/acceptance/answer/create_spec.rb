require_relative '../acceptance_helper'

feature 'answer a question', %q(
  In oreder to help someone
  As a registred user
  I want to give an answer
  ) do

    given(:question){ create(:question)  }
    given(:user){ create(:user) }

    scenario 'giving an answer' do
      sign_in(user)
      sharing_of_advice(question)
      expect(page).to have_content 'Thank you for you Answer'
      expect(page).to have_link 'Share your experiance and wisdom'
    end
    
    scenario 'answer apears after its create' do
      visit question_path(question)
      expect(page).to have_content 'First of all you need ...'\
                  ' and only then ... Best Regards and Good luck!'
    end
end