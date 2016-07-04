require_relative '../acceptance_helper'

feature 'create question', %q(
  In order to get help
  as a noobie user
  I want to be able ask for help  -- ) do

  scenario 'asking for help' do
    ask_for_help
    expect(page).to have_content 'Please wait for a while,'\
                            ' someone will answer you soon.'
  end
  	
end