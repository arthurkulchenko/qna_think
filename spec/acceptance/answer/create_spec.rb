require_relative '../acceptance_helper'

feature 'answer a question', %q(
  In oreder to help someone
  As a registred user
  I want to give an answer
  ) do

    given(:question){ create(:question)  }
    given(:user){ create(:user) }
    background { sharing_of_advice(question) }
    
    scenario 'giving an answer' do
      expect(page).to have_content 'Thank you for you Answer'
      expect(page).to have_link 'Offer solution'
    end
    
    scenario 'answer apears after its create' do
      expect(page).to have_content 'First of all you need ...'\
                  ' and only then ... Best Regards and Good luck!'
    end
end