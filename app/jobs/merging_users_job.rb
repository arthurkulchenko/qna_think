  class MergingUsersJob < ApplicationJob
  queue_as :default

  def perform(old_user, new_user)
    if new_user.persisted? && old_user.persisted?
      User.transaction do
        User.associations_list.each do |association|
          old_user.send(association).each do |instance|
            instance.update!(user_id: new_user.id)
          end 
        end
        old_user.destroy!
      end
      new_user
    end
  end
end
