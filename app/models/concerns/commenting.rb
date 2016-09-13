module Commenting
	
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :comments_parent
  end	
end