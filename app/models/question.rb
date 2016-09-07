class Question < ApplicationRecord
	
  include Voting
  include Attaching

  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, :content, presence: true
end
