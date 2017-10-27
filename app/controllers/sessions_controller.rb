class SessionsController < ApplicationController
  def create
    @user = User.find_by_provider_and_uid(auth_hash.provider,auth_hash.uid) || User.from_omniauth(auth_hash)

    session[:user_id]=@user.uid
    redirect_to session[:return_to]
  end

  def destroy
      session.delete(:user_id)
      flash[:notice]='Logged out successfully'
      redirect_to root_path
  end
  
  protected

  def auth_hash
    request.env['omniauth.auth']
  end
  
end
