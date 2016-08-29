require_relative '../acceptance_helper'

feature 'unvote', %q(
  If I change my mind about vote
  As regular auth user
  I wish to be able tack back my voice
) do
  given(:user){ create(:user) }
  given(:question){ create(:question) }
  # given!(:answer){ create(:answer, question: question) }
  given!(:vote){ create(:voted_plus, ballot_id: question.id, ballot_type: question.class, user: user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'user try to unvote' do
    save_and_open_page
    expect(page).to have_link "Take back your voice"
    click_on "Take back your voice"
    visit question_path(question)
    expect(page).to_not have_link "Take back your voice"
  end
	
end