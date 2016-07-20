require_relative '../acceptance_helper'

feature 'registration', %q(
To do some actions like give answer or ask for question
As regilar user
I want to register in system to recive posobility
)do
  given!(:user) { create(:user) }
  scenario 'sign up' do
    registration
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end