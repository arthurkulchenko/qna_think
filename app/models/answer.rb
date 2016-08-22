class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  has_many :votes, as: :ballot

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :content, presence: true

  after_create :create_voting

  before_update :check_of_best

  scope :best_first, -> { order(best_answer: :desc) }

  def answers_stack
    question.answers
  end

  private

  def mark_count
    votes.map{|i| @mark += i.mark}
    mark = @mark
  end

  def create_voting
    votes.create
  end
  
  def check_of_best
    return unless @best_answer = question.answers.where(best_answer: true).first
    return @best_answer.toggle(:best_answer).save unless ( id == @best_answer.id ) || ( !best_answer )
  end

  

end
