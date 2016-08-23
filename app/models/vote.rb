class Vote < ApplicationRecord
  belongs_to :ballot, polymorphic: true
  belongs_to :user
  
  after_create :total_mark
  
  private

  def total_mark
    @obj = ballot_type.constantize.find(ballot_id)
    @obj.update(mark: @obj.votes.pluck(:mark).sum)
  end

end
