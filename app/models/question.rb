class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  validates :title, :content, presence: true
end
