class CampAttendancesController < ApplicationController
layout 'priv'
def edit
  @camp_att = CampAttendance.where(:user_id => current_user).first
  if @camp_att.nil?
    @camp_att = CampAttendance.new
    @camp_att.user_id = current_user.id
  end
end

def show
  @camp_att = CampAttendance.where(:user_id => current_user).first
end

def create
  @camp_att = CampAttendance.where(:user_id => current_user).first
  if @camp_att.nil?
    @camp_att = CampAttendance.new
    @camp_att.user_id = current_user.id
  end
  @camp_att.by_car = params[:by_car]
  @camp_att.memo = params[:memo]
  params[:selections].each_char.with_index(1) do |val, idx|
    @camp_att.send(('section_' + idx).to_sym) = val
  end
  if @camp_att.save!
    redirct_to @camp_att
  else
    render 'edit'
  end
end

end
