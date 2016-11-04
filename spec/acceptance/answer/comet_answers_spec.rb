require_relative '../acceptance_helper'
feature 'comet answer', %q(
  To share some answer immediatley
  As auth user
  Answer must appears at the same time as it was added on every window where it was open
) do
  pending("works with helper")
  # given(:user){ create(:user)}
  # given(:user2){ create(:user)}
  # given(:question){ create(:question, user: user2)}
  # given!(:answer){ create(:answer, user: user, question: question, content: 'IMHO')}

  # background do
  #   sign_in(user)
  #   visit question_path(question)
  # end

  # scenario 'commenting answer', js: true do
  #   within "#answer_#{answer.id}" do
  #     fill_in 'Your Comment', with: 'IMHO'
  #     click_on 'Post Comment'
  #     # Works only with save_and_open_page
  #     # save_and_open_page 
  #     expect(page).to have_content 'IMHO'
  #   end
  # end

end