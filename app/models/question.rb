class Question < ApplicationRecord
	
  include Voting
  include Attaching
  include Commenting
  include BelongiesToUser

  has_many :answers, dependent: :destroy

  validates :title, :content, presence: true
end
