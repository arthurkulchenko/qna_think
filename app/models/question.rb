class Question < ApplicationRecord	
  include Voting
  include Attaching
  include Commenting
  include BelongingsOfUser

  has_many :answers, dependent: :destroy
  
  after_create :post_via_comet
  #  Custom validation do not pass tests, but it makes errors more pretty
  # validates_with Validators::QuestionValidator, fields: [:title, :content]
  validates :title, :content, presence: true
  
  private

  def post_via_comet
    ActionCable.server.broadcast '/questions',
                                  ApplicationController.render( 
                                  	                            partial: 'questions/new_question',
                                                                locals: { question: self } 
                                                               )
  end
end