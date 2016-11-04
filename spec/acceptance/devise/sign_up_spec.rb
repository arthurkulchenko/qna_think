require_relative '../acceptance_helper'

feature 'registration', %q(
  To do some actions like give answer or ask for question
  As regilar user
  I want to register in system to recive posobility
)do
  pending('devise helper used')
  # given!(:user) { create(:user) }
  # scenario 'sign up' do
  #   visit new_user_registration_path
  #   %Q(Email Password Password\ confirmation).split.each{|e| fill_in e, with: 'usered@example.fi'}
  #   click_on 'Sign up'
  #   expect(page).to have_content 'Welcome! You have signed up successfully.'
  # end
end