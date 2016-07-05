require_relative '../acceptance_helper'

feature 'loggin out', %q(
To end session
As authenticated user
I want to log out
)do
  scenario 'sign out' do
    sign_out
  end
end