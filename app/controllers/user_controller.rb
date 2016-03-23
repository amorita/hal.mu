class UserController < ApplicationController

def login

  if params[:google_bot_user] && params[:google_bot_pass]
    if params[:google_bot_user] == ConstantValue.where(:key => 'google_bot_user').first.value &&
      params[:google_bot_pass] == ConstantValue.where(:key => 'google_bot_pass').first.value

      sign_in(:user, User.find(124))
    end
  end

	if user_signed_in?
		redirect_to :controller => 'main', :action => 'index'
	end
end

end
