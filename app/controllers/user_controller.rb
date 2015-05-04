class UserController < ApplicationController

def login
	if user_signed_in?
		redirect_to :controller => 'main', :action => 'index'
	end
end

end
