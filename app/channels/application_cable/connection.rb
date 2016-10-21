# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
 
    def connect
      self.current_user = find_verified_user
      # logger.add_tags env['warden'].user
      # logger.add_tags current_user
      # logger.add_tags 'ActionCable', current_user.email
    end
 
    protected

    def find_verified_user
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    # verified_user = env['warden'].user ? verified_user : reject_unauthorized_connection
    #   if current_user = User.find_by(id: cookies.signed[:user_id])
    #     current_user
    #   else
    #     reject_unauthorized_connection
    #   end
    end
  end

end