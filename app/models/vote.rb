class Vote < ApplicationRecord
  
  include BelongingsOfUser

  belongs_to :ballot, polymorphic: true
  
  validates :mark, inclusion: { in: [1,0,-1], message: "%{value} is not a valid value" }

  after_create :delete_same_users_vote, :update_mark_sum
  after_destroy :update_mark_sum

  before_destroy :authorship_verivication
  
  private

  def authorship_verification
    redirect_to self, notice: 'Deny!' unless current_user.is_author_of?(self)
  end

  def delete_same_users_vote
    @votes = Vote.where(ballot: ballot, user: user_id)
    @votes.first.destroy if @votes.count > 1
  end

  def update_mark_sum
    ballot.update(mark: ballot.votes.sum(:mark))
  end

end