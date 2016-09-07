class Vote < ApplicationRecord
  belongs_to :ballot, polymorphic: true
  belongs_to :user
  
  validates :mark, inclusion: { in: [1,0,-1], message: "%{value} is not a valid value" }
  validates :user_id, presence: true

  after_create :delete_same_users_vote, :update_mark_sum
  after_destroy :update_mark_sum
  
  private

  def delete_same_users_vote
    @votes = Vote.where(ballot: ballot, user: user_id)
    @votes.first.destroy if @votes.count > 1
  end

  def update_mark_sum
    ballot.update(mark: ballot.votes.sum(:mark))
  end

end