class Comment < ApplicationRecord
  
  include BelongiesToUser

  belongs_to :comments_parent, polymorphic: true
  validates :comments_parent_type, presence: true

end
