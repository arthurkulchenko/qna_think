class Question < ApplicationRecord	
  include Voting
  include Attaching
  include Commenting
  include BelongingsOfUser

  has_many :answers, dependent: :delete_all

  # validates :title, :content, presence: true#, { message: "#{value} can not be empty" }
  validates_with Validators::QuestionValidator
end