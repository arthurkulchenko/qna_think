class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :content, :user_id, presence: true

  before_update :check_of_best

  scope :best_first, -> { order(best_answer: :desc) }

  private
  
  def check_of_best
    return unless @best_answer = question.answers.where(best_answer: true).first
    return @best_answer.toggle(:best_answer).save unless ( id == @best_answer.id ) || ( !best_answer )
  end

end
