require_relative '../acceptance_helper'

feature 'deleting question', %q(
In order to delete question
As a auth user
I want to delete my own question
)do
  given(:user) { create(:user) }
  given(:question){ create(:question, user: user) }
  scenario 'only owner can delete question' do

  end
end