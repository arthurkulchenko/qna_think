module Commenting
	
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :comments_parent

    def to_channel_name
      self.class.to_s.downcase.pluralize
    end
  end	
end