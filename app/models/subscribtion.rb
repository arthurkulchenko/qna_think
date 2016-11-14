class Subscribtion < ApplicationRecord
  include BelongingsOfUser
  # TOTEST
  belongs_to :subscribtable, polymorphic: true
end
