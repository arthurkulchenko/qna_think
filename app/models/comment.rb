class Comment < ApplicationRecord
  
  include BelongiesToUser

  belongs_to :parent, polymorphic: true
  validates :comments_parent_type, :content, presence: true

end
