require_relative '../acceptance_helper'

feature 'unvote', %q(
  If I change my mind about vote
  As regular auth user
  I wish to be able tack back my voice
) do
  given(:user){ create(:user) }
  given(:question){ create(:question, user: user) }
  given!(:answer){ create(:answer, question: question) }

  background do
    sign_in(user)
    visit question_path(question)
  end
	
end