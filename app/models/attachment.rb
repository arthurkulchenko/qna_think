class Attachment < ApplicationRecord
  include BelongingsOfUser
  belongs_to :attachable, polymorphic: true
  mount_uploader :file, FileUploader
end
