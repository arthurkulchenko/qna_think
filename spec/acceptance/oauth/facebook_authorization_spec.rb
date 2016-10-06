feature 'loggin via facebook', %q{
  In order to use application without registration procedure
  As user who have facebook account
  I want to log in
  } do
  background do
    mock_auth[:facebook]
  end
  context "with email" do
    context "without account" do
      # given!(:user){ create(:user, email: 'facebook@facebook.com') }
      scenario 'try log in without account in current application' do
        visit root_path
        click_on 'Log in'
        click_on 'Sign in with Facebook'
        expect(page).to have_button 'Log out'
      end
     end
  
    context "with account" do
      given!(:user){ create(:user, email: 'facebook@email.com', email_real: true) }
      scenario 'try log in without account in current application' do
        visit root_path
        click_on 'Log in'
        click_on 'Sign in with Facebook'
        expect(page).to have_link 'Log out'
      end
    end
  end
  context "without email" do
    context "without account" do
      given!(:user){ create(:user) }
      scenario 'try log in without account in current application' do
        visit root_path
        click_on 'Log in'
        click_on 'Sign in with Facebook'
        expect(page).to have_button 'Log in'
      end
     end
  
    context "with account" do
      given!(:user){ create(:user) }
      scenario 'try log in with account in current application' do
        visit root_path
        click_on 'Log in'
        click_on 'Sign in with Facebook'
        expect(page).to have_button 'Log in'
      end
    end
  end
end