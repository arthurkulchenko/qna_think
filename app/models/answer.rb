class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :content, :user_id, presence: true

  before_update :check_of_best

  scope :best_first, -> { order(best_answer: :desc) }

  private
  
  def it_already_have_best_answer?
    @best_answer = question.answers.map{|i| i if i.best_answer == true }.compact.first
  end

  def check_of_best
    if it_already_have_best_answer?
      if ( id == @best_answer.id ) || ( best_answer == false )
      else
        @best_answer.best_answer = false
        @best_answer.save
      end     
    end
  end
  
end
