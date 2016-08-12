require_relative '../acceptance_helper'

feature 'attaching file', %q(
  In order to describe something more detail
  As auth user
  I whant to attache file
) do
  given(:user){create(:user)}
  given(:question){create(:question)}
  background do
    sign_in(user)
    visit question_path(question)
  end
  scenario '**atttaching file' do

    # click_on 'Offer solution'
    fill_in 'Form for Answer', with: 'First of all you need ...'\
                  ' and only then ... Best Regards and Good luck!'
    attache_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Provide an answer'
    within '.answer' do
      expect(page).to have_content "spec_helper.rb"
      expect(page).to have_link
    end
  end
end