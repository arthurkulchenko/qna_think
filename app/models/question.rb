class Question < ApplicationRecord	
  include Voting
  include Attaching
  include Commenting
  include Subscribing
  include BelongingsOfUser

  has_many :answers, dependent: :destroy
  
  after_create :post_via_comet, :subscribe_on_new_answers
  after_update :background_job

  #  Custom validation do not pass tests, but it makes errors more pretty
  # validates_with Validators::QuestionValidator, fields: [:title, :content]
  validates :title, :content, presence: true
  scope :last_24_hours, -> { where(created_at: DateTime.yesterday) }
  
  private

    def question_newsletter
      QuestionChangingsJob.perform(self)
    end
  
    def subscribe_on_new_answers
      Subscribtion.create(user: user, subscribtable: self)
    end
  
    def background_job
      # TODO need to add cheking if content or title updated
      self.question_newsletter
    end
  
    def post_via_comet
      ActionCable.server.broadcast '/questions',
                                    ApplicationController.render( 
                                    	                            partial: 'questions/new_question',
                                                                  locals: { question: self } 
                                                                 )
    end
end