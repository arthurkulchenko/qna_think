class Question < ApplicationRecord
  include ActiveModel::Dirty
  include Voting
  include Attaching
  include Commenting
  include Subscribing
  include BelongingsOfUser

  has_many :answers, dependent: :destroy
  validates :title, :content, presence: true
  
  after_create :post_via_comet, :subscribe_on_new_answers
  after_update :question_newsletter

  scope :last_24_hours, -> { where(created_at: DateTime.yesterday) }

  def question_newsletter
    QuestionChangingsJob.perform_now(self) if self.content_changed?
  end
  
  private
  
    def subscribe_on_new_answers
      Subscribtion.create(user: user, subscribtable: self)
    end
  
    def post_via_comet
      ActionCable.server.broadcast '/questions',
                                    ApplicationController.render( 
                                    	                            partial: 'questions/new_question',
                                                                  locals: { question: self } 
                                                                 )
    end
end