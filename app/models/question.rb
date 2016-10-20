class Question < ApplicationRecord	
  include Voting
  include Attaching
  include Commenting
  include BelongingsOfUser

  has_many :answers, dependent: :delete_all
  
  after_create :post_via_comet
  
  validates_with Validators::QuestionValidator
  
  private

  def post_via_comet
    ActionCable.server.broadcast '/questions',
                                  ApplicationController.render( 
                                  	                          partial: 'questions/new_question',
                                                                locals: { question: self } 
                                                               )
  end
end