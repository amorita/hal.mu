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

def update
  create
end

def create
  @camp_att = CampAttendance.where(:user_id => current_user).first
  if @camp_att.nil?
    @camp_att = CampAttendance.new
    @camp_att.user_id = current_user.id
  end
  @camp_att.by_car = params[:camp_attendance][:by_car]
  @camp_att.memo = params[:camp_attendance][:memo]
  params[:selections].each_char.with_index(1) do |val, idx|
    eval '@camp_att.section_' + idx.to_s  + ' = val'
  end
  @camp_att.updated_at = Time.now
  if @camp_att.save!
    redirect_to @camp_att
  else
    render action: 'edit'
  end
end

def index
  @users = User.all.order :part_id
end

end
