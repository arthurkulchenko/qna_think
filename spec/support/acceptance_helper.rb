module AcceptanceHelper

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def sign_out
    click_on 'Log out'
  end
# TODO hi
  def registration(user)
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
  end

  def sharing_of_advice(question)
    sign_in(user)
    visit question_path(question)
    click_on 'Offer solution'
    fill_in 'Form for Answer', with: 'First of all you need ...'\
                  ' and only then ... Best Regards and Good luck!'
    click_on 'Provide an answer'
  end

  def ask_for_help
    sign_in(user)
    visit root_path
    click_on 'Ask a question'
    fill_in 'Problem', with: 'ern Error: missing important thing code:234'
    fill_in 'Description', with: 'Every time, when I do ..., I get ..., what should I do?'
    click_on 'Ask for Help'
  end
end