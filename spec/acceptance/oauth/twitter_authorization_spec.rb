feature 'loggin via twitter', %q{
  In order to use application without registration procedure
  As user how have twitter account
  I want to log in
  } do
  background do
    mock_auth[:twitter]
  end
  context "without" do
    given!(:user){ create(:user, email: 'twitter@twitter.com') }
    scenario 'try log in without account in current application' do
      visit root_path
      click_on 'Log in'
      click_on 'Sign in with Twitter'
      expect(page).to have_button 'Send me an email'
    end
   end

  context "within" do
    given!(:user){ create(:user, email: 'twitter@email.com', email_confirmed: true) }
    scenario 'try log in without account in current application' do
      visit root_path
      click_on 'Log in'
      click_on 'Sign in with Twitter'
      # expect(page).to have_link 'Log out'
      expect(page).to have_button 'Send me an email'
    end
   end
end