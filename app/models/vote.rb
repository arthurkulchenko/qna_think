class Vote < ApplicationRecord
  include BelongingsOfUser

  belongs_to :ballot, polymorphic: true
  
  validates :mark, inclusion: { in: [-1,0,1], message: "%{value} is not a valid value" }

  after_create :delete_same_users_vote, :updating_in_bg
  after_destroy :updating_in_bg

  private

  def delete_same_users_vote
    @votes = Vote.where(ballot: ballot, user: user_id)
    @votes.first.destroy if @votes.count > 1
  end

  def update_mark_sum
    ballot.update(mark: ballot.votes.sum(:mark))
  end


  def updating_in_bg
    self.delay.update_mark_sum
    # update_mark_sum
  end
  handle_asynchronously :updating_in_bg
end