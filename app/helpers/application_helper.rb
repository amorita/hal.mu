module ApplicationHelper
	def is_granted(*responsibles)
		if current_user.admin
			return true
		end

		for res in responsibles.class do 
			if Responsible.where(:name => res.to_s, :user_id => current_user.id).count > 0
				return true
			end
		end
		return false
	end
end
