module Voting
	
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :ballot, dependent: :destroy
  end	
end