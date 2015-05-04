class MainController < ApplicationController

before_filter :authenticate_user!
layout false

def index
	if current_user.phone.nil?
		render 'welcome' and return
	end
	if current_user.updated_at.nil? || current_user.updated_at < Date.today << 6
		render 'info_update_required' and return
	end
	@user = current_user
end

end
