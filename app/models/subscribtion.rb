class Subscribtion < ApplicationRecord
  include BelongingsOfUser
  belongs_to :subscribtable, polymorphic: true
end
