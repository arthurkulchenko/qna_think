class Comment < ApplicationRecord
  
  include BelongiesToUser

  belongs_to :comments_parent, polymorphic: true
end
