module Voting
	
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :ballot
  end	
end