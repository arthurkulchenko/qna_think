class MergingUsersJob < ApplicationJob
  queue_as :default

  def perform(old_user, new_user )
    User.transaction do
      User.associations_list.each do |association|
        old_user.send(association).each do |instance|
          instance.update(user_id: new_user.id)
        end
        old_user.destroy
        new_user.save
      end
    end
    new_user
  end
end
