feature 'confirmating email', %q(
In order to confirm email address of users how try to log in via 3p
As non auth user
I want to recive mail to confirm my email address
) do
  let!(:token){ SecureRandom.base64(18) }
  let!(:user){ create(:user, email_confirmation_token: token, email_confirmed: false, email: 'default@email.com') }
  background do
    clear_emails
    visit root_path
    click_on 'Log in'
    click_on 'Sign in with Facebook'
    click_on 'Send me an email'
    visit set_email_path(token)
    # Will find an email sent to test@example.com
    # and set `current_email`
    open_email('default-1234@email.com')
  end

  scenario 'following a link' do
    # current_email.subject
    current_email.click_link 'this link'
    expect(page).to have_content 'Log out'
    current_email.save_and_open
  end

end