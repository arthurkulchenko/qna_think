require_relative '../acceptance_helper'

feature 'unvote', %q(
  If I change my mind about vote
  As regular auth user
  I wish to be able tack back my voice
) do
  pending("do not need")
  # given(:user){ create(:user) }
  # given(:user2){ create(:user) }
  # given(:question){ create(:question) }
  # given!(:vote){ create(:voted_plus, ballot_id: question.id, ballot_type: question.class, user: user) }

  # scenario 'user try to unvote' do
  #   sign_in(user)
  #   visit question_path(question)
  #   # save_and_open_page
  #   click_on "Take back your voice"
  #   visit question_path(question)
  #   expect(page).to_not have_link "Take back your voice"
  # end

  # scenario 'not owner of vote do not see link' do
  #   sign_in(user2)
  #   visit question_path(question)
  #   expect(page).to_not have_link "Take back your voice"
  # end
	
end