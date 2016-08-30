class Vote < ApplicationRecord
  belongs_to :ballot, polymorphic: true
  belongs_to :user
  
  after_create :delete_same_users_vote, :update_mark_sum
  after_destroy :update_mark_sum
  
  private

  def delete_same_users_vote
    @user = User.find(user_id)
    @user.votes.where(ballot: ballot).first.destroy if @user.votes.where(ballot: ballot).count > 1
  end

  def update_mark_sum
    ballot.update(mark: ballot.votes.sum(:mark))
  end

end