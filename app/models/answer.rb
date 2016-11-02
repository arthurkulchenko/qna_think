class Answer < ApplicationRecord
  include Voting
  include Attaching
  include Commenting
  include BelongingsOfUser
  
  belongs_to :question

  validates :content, :question_id, presence: true

  before_update :check_of_best

  scope :best_first, -> { order(best_answer: :desc) }
  scope :not_best_answers, -> { where(best_answer: false) }
  
  private

  def check_of_best
    return unless @best_answer = question.answers.best_first.first
    return @best_answer.toggle(:best_answer).save unless ( id == @best_answer.id ) || ( !best_answer )
  end

end