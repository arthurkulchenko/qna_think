module ControllerMacros

  def sign_in_user(user=nil)
    before do
      @user = user ? user : create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end
  end

  def sign_out_user(user=nil)
    @user = user ? user : create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_out @user  
  end

  def current_user_in
    subject.current_user
  end
end