module Voting
	
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :ballot
    validates :user_id, presence: true
  end	
end