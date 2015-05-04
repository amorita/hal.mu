class Application < ActiveRecord::Base
	belongs_to :user
	belongs_to :part_user, :class_name => "User"

	def application_name
		case self.application_type
		when 'join'
			return '入団届'
		when 'absence'
			return '休団届'
		when 'retire'
			return '退団届'
		else
			return ''
		end
	end
	
end
