require_relative '../acceptance_helper'

feature 'create question', %q(
  In order to get help
  as a noobie user
  I want to be able ask for help  -- ) do
  
  given(:user){ create(:user) }
  background do
    sign_in(user)
    visit root_path
    click_on 'Ask a question'
    fill_in 'Problem', with: 'ern Error: missing important thing code:234'
    fill_in 'Description', with: 'Every time, when I do ..., I get ..., what should I do?'
    click_on 'Ask for Help'
  end
  scenario 'asking for help' do
    expect(page).to have_content 'Please wait for a while,'\
                            ' someone will answer you soon.'
    expect(page).to have_content 
  end
  	
end