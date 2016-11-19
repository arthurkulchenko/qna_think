module Subscribing
	
  extend ActiveSupport::Concern

  included do
    has_many :subscribtions, as: :subscribtable, dependent: :destroy
  end	
end