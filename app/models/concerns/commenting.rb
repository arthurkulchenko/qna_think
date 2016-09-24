module Commenting
	
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :parent
  end	
end