class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :content, :user_id, presence: true
end
