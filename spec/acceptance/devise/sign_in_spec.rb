require_relative '../acceptance_helper'

feature 'logginig', %q(
  To do some actions like give answer or ask for question
  As regilar user
  I need to log in in system to work with
  )do
    given(:user) { create(:user) }
    scenario 'sign in' do
      sign_in(user)
      expect(page).to have_content 'Signed in successfully.'
    end
end