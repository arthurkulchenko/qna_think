class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :title, :content, presence: true
end
