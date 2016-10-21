module AnswerHelper
  def user_authenticate_in?
    # if false #!user_signed_in?.blank?
    #   true
    # else
    #   if User.find_by(id: cookies.signed['user.id']) && cookies.signed['user.expires_at'] > Time.now
    #     true
    #   else
    #     false
    #   end
    # end
    true
  end

  def current_user_helper
    # if cookies.signed['user.id'] && cookies.signed['user.expires_at'] > Time.now
      User.find_by(id: cookies.signed['user.id'])
    # else
      # current_user
    # end
  end

end