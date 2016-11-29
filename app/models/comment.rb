class Comment < ApplicationRecord
  include BelongingsOfUser

  belongs_to :parent, polymorphic: true
  validates :parent_type, :content, presence: true

  after_save ThinkingSphinx::RealTime.callback_for(:comment)
end