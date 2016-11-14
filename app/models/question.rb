class Question < ApplicationRecord	
  include Voting
  include Attaching
  include Commenting
  include BelongingsOfUser

  has_many :answers, dependent: :destroy
  
  after_create :post_via_comet
  after_update :question_newsletter
  #  Custom validation do not pass tests, but it makes errors more pretty
  # validates_with Validators::QuestionValidator, fields: [:title, :content]
  validates :title, :content, presence: true
  scope :last_24_hours, -> { where(create_at: DateTime.yesterday) }
  
  private
  # TOTEST
  def digest
    if Date.today.at_middle_of_day()
      QuestionSubscriptionMailer.send_digest(User.digest_subscribers, Question.last_24_hours).deliver_later(:queue)
    end
  end
  # TOTEST
  def question_newslatter
    QuestionSubscriptionMailer.question_newslettering(User.subscribed_on_changings(self), self)
  end

  def post_via_comet
    ActionCable.server.broadcast '/questions',
                                  ApplicationController.render( 
                                  	                            partial: 'questions/new_question',
                                                                locals: { question: self } 
                                                               )
  end
end