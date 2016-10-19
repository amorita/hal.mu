class MuttersController < ApplicationController

	def index
		@mutters = Mutter.all.last 10
	end

	def create
    mutter = Mutter.new
    mutter.message = params['message']
    mutter.user_id = current_user.id
    mutter.save!
    redirect_to action: 'index'
  end

end
