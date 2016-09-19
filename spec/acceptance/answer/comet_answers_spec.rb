require_relative '../acceptance_helper'
# DO NOT WORK
feature 'comet answer', %q(
  To share some answer immediatley
  As auth user
  Answer must appears at the same time as it was added on every window where it open
) do
  given(:user){ create(:user)}
  given(:user2){ create(:user)}
  given(:question){ create(:question, user: user2)}
  given!(:answer){ create(:answer, user: user, question: question)}

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'commenting answer', js: true do
    within '.answer' do
      fill_in 'Your Comment', with: 'IMHO'
      click_on 'Post Comment'
      save_and_open_page
      expect(page).to have_content 'IMHO'
    end
  end

end