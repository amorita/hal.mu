class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  layout false

  def facebook; basic_action; end
  def twitter; basic_action; end
  def github; basic_action; end
  def google; basic_action; end
  def hatena; basic_action; end
  def linkedin; validate; end
  def mixi; basic_action; end
  def hatena; basic_action; end
  def yahoo; basic_action; end

  private
  def basic_action
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
      unless @profile
        @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).new
        if !user_signed_in?
          @param = SignInParam.new
          @param.provider = @omniauth['provider']
          render 'sign_in' and return
        end
        
        @profile.user = current_user 
        @profile.save!
      end
      if current_user
        raise "user is not identical" if current_user != @profile.user
      else
        sign_in(:user, @profile.user)
      end
      @profile.set_values(@omniauth)
    end
    redirect_to :controller => '/main', :action => 'index'
  end
end
  
