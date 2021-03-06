module ApplicationHelper
	def is_granted(*responsibles)
		if current_user.admin
			return true
		end

		responsibles.each do |res| 
			if Responsible.where(:name => res.to_s, :user_id => current_user.id).count > 0
				return true
			end
		end
		return false
	end

	def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn btn-info", data: {id: id, fields: fields.gsub("\n", "")})
  end

def protect_against_forgery?
      false
 end

end
