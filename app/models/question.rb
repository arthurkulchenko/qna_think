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
  scope :last_24_hours, -> { where(created_at: DateTime.yesterday) }
  
  private
  # TOTEST
  def question_newsletter
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