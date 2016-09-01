require_relative '../acceptance_helper'

feature 'unvote', %q(
  If I change my mind about vote
  As regular auth user
  I wish to be able tack back my voice
) do
  given(:user){ create(:user) }
  given(:user2){ create(:user) }
  given(:question){ create(:question, user: user) }
  given!(:answer){ create(:answer, question: question) }
  given!(:vote){ create(:voted_plus, ballot: answer, user: user) }

  scenario 'not owner of answer try to unvote his own vote' do
    sign_in(user)
    visit question_path(question)
    click_on "Take back your voice"
    visit question_path(question)
    expect(page).to_not have_link "Take back your voice"
  end

  scenario 'not owner of vote do not see link' do
    sign_in(user2)
    visit question_path(question)
    expect(page).to_not have_link "Take back your voice"
  end
	
end