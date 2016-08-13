require_relative '../acceptance_helper'

feature 'attaching file', %q(
  In order to describe something more detail
  As auth user
  I whant to attache file
) do
  given(:user){create(:user)}
  background do
    sign_in(user)
    visit new_question_path
  end
  scenario '**atttaching file' do
    fill_in 'Problem', with: 'ern Error: missing important thing code:234'
    fill_in 'Description', with: 'Every time, when I do ..., I get ..., what should I do?'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Ask for Help'
    within '.answer' do
      expect(page).to have_content "spec_helper.rb"
      expect(page).to have_link 'add file'
    end
  end
end