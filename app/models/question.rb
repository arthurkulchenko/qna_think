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

  def question_newsletter
    Subscribtion.where(subscribtable: self).find_each do |subscribtion|
      unless subscribtion.user.is_author_of?(self)
        QuestionSubscriptionMailer.question_changings_lettering(subscribtion.user, self)
      end
    end
  end
  
  private

  def subscribe_on_new_answers
    Subscribtion.create(user: user, subscribtable: self)
    self.question_newsletter
  end

  # TOTEST
  # WHY IT FAILS?
  # def question_newsletter
  #   Subscribtion.where(subscribtable: self).find_each do |subscribtion|
  #     unless subscribtion.user.is_author_of?(self)
  #       QuestionSubscriptionMailer.question_changings_lettering(subscribtion.user, self)
  #     end
  #   end
  # end

  def background_job
    self.delay.question_newsletter
  end

  def post_via_comet
    ActionCable.server.broadcast '/questions',
                                  ApplicationController.render( 
                                  	                            partial: 'questions/new_question',
                                                                locals: { question: self } 
                                                               )
  end
end