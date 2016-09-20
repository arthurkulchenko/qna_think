class Comment < ApplicationRecord
  
  include BelongiesToUser

  belongs_to :comments_parent, polymorphic: true
  validates :comments_parent_type, :content, presence: true

  def parent
    parent ||= comments_parent_type.constantize.find(comments_parent_id)
  end

end
