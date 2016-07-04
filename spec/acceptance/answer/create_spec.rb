require_relative '../acceptance_helper'

feature 'answer a question', %q(
  In oreder to help someone
  As a registred user
  I want to give an answer
  ) do

    given(:question){ create(:question)  }

    scenario 'giving an answer' do
      sharing_of_advice
      expect(page).to have_content 'Thank you for you Answer'
      expect(page).to have_link 'Share you experiance and wisdom'
    end
end