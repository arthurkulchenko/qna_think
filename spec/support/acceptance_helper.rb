# require 'rails_helper'
module AcceptanceHelper
  # require 'rails_helper'
  # def sign_in(user)
  #   visit new_user_session_path # or '/sign_in'
  #     fill_in 'Email', with: user.email
  #     fill_in 'Password', with: user.password
  #     click_on 'Log in'
  # end

  # def sign_out
  #   click_on 'list of communitis'
  #   click_on 'sign out'
  # end

  def sharing_of_advice
    visit question_path(question)
    click_on 'Share you experiance and wisdom'
    fill_in 'Form for Answer', with: 'First of all you need ...'\
                  ' and only then ... Best Regards and Good luck!'
    click_on 'Provide an answer'
  end

  def ask_for_help
    visit root_path
    click_on 'Ask a question'
    # expect(page).to have_current_path new_question_path
    fill_in 'Problem', with: 'ern Error: missing important thing code:234'
    fill_in 'Description', with: 'Every time, when I do ..., I get ..., what should I do?'
    click_on 'Ask for Help'
  end
end