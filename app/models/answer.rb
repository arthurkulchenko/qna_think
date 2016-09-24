class Answer < ApplicationRecord

  include Voting
  include Attaching
  include Commenting
  include BelongingsOfUser
  
  belongs_to :question

  validates :content, presence: true

  before_update :check_of_best

  scope :best_first, -> { order(best_answer: :desc) }
  scope :not_best_answers, -> { where(best_answer: false) }


  # before_destroy :authorship_verivication
  
  private

  def authorship_verification
    redirect_to self, notice: 'Deny!' unless current_user.is_author_of?(self)
  end
  
  def check_of_best
    return unless @best_answer = question.answers.best_first.first
    return @best_answer.toggle(:best_answer).save unless ( id == @best_answer.id ) || ( !best_answer )
  end

end
