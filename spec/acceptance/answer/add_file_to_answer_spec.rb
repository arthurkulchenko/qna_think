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
  scenario '**atttaching file', js: true do
    fill_in 'Form for Answer', with: 'First of all you need ...'\
                  ' and only then ... Best Regards and Good luck!'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Provide an answer'
    within '.answers' do
      expect(page).to have_content "spec_helper.rb"
      expect(page).to have_link 'add file'
    end
  end
end