feature 'loggin out', %q(
To end session
As authenticated user
I want to log out
)do
  given(:user){ create(:user) }
  scenario 'sign out' do
    sign_in(user)
    sign_out(user)
    expect(page).to have_content 'Signed out successfully.'
  end
end