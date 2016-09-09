require_relative '../acceptance_helper'

feature 'comet answer', %q(
  To share some answer immediatley
  As auth user
  Answer must appears at the same time as it was added on every window where it open
) do
  given(:user){ create(:user)}
  given(:user_2){ create(:user)}
  given(:question){ create(:question, user: user2)}
  given(:answer){ create(:answer, user: user, question: question)}

  # background do
  #   sign_in user
  #   sign_in user_2
  #   visi
  # end

  # scenario

end