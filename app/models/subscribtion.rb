class Subscribtion < ApplicationRecord
  include BelongingsOfUser
  # TOTEST
  belongs_to :subscribtable, polymorphic: true

  after_create :mailing

  private
    def mailing
      QuestionSubscriptionMailer.new_answer_letter(question.user, self)#.deliver_later(:queue)
    end
end
