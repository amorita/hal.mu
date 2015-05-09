class AuthController < ApplicationController

def validate
	param = params['sign_in_param']
	user = User.where(:email => param['email'], :initial_access_token => param["initial_access_token"]).first

	unless user
		@param = SignInParam.new
        @param.provider = param['provider']
        @param.errors[:base] << 'error'
        @param.email = param['email']
        render template: 'omniauth_callbacks/sign_in' and return
    end

    sign_in(:user, user)
    redirect_to '/user/auth/' + param['provider']
end

def logout
	sign_out current_user
	redirect_to 'http://hal.mu/'
end
end
