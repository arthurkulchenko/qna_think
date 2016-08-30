module Voting
	
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :ballot
    before_update :check_uniqness_of_users_vote
  end

  def check_uniqness_of_users_vote
      # votes.where(user:)
  end
	
end