class MergingUsersJob < ApplicationJob
  queue_as :default

  def perform(old_user, new_user )
    User.transaction do
      old_user.authorizations.each do |i|
        i.update(user_id: new_user.id)
      end
      old_user.questions.each do |i|
        i.update(user_id: new_user.id)
      end
      old_user.answers.each do |i|
        i.update(user_id: new_user.id)
      end
      old_user.votes.each do |i|
        i.update(user_id: new_user.id)
      end
      old_user.comments.each do |i|
        i.update(user_id: new_user.id)
      end
      old_user.attachments.each do |i|
        i.update(user_id: new_user.id)
      end
      old_user.subscribtions.each do |i|
        i.update(user_id: new_user.id)
      end
      old_user.destroy
      new_user.save
    end
    new_user
  end
end
