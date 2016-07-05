class CampAttendancesController < ApplicationController
layout 'priv'
before_filter :authenticate_user!
def edit
  if view_context.is_granted :camping_coordinator
    @camp_att = CampAttendance.find(params[:id])
  else
    redirect_to :action => 'show'
  end
end

def edit_self
  @camp_att = CampAttendance.where(:user_id => current_user).first
  if @camp_att.nil?
    @camp_att = CampAttendance.new
    @camp_att.user_id = current_user.id
  end
  render "edit"
end

def show
  if @camp_att.nil?
    @camp_att = CampAttendance.where(:user_id => current_user).first
  end
end

def update
  create
end

def create
  if params[:camp_attendance][:user_id].present?
    user_id = params[:camp_attendance][:user_id]
  else
    user_id = current_user.id
  end

  @camp_att = CampAttendance.where(:user_id => user_id).first
  if @camp_att.nil?
    @camp_att = CampAttendance.new
    @camp_att.user_id = current_user.id
  end
  @camp_att.by_car = params[:camp_attendance][:by_car]
  @camp_att.memo = params[:camp_attendance][:memo]
  params[:selections].each_char.with_index(1) do |val, idx|
    eval '@camp_att.section_' + idx.to_s  + ' = val'
  end
  @camp_att.updated_at = Time.now + (3600 * 9)
  if @camp_att.save!
    redirect_to @camp_att
  else
    render action: 'edit'
  end
end

def payment_status
  @camp_attendances = CampAttendance.joins(:user).order("users.part_id, users.family_name_pron, users.name_pron")
end

def update_payment_status
  list = params[:payed_list].keys
  list.each do |payed|
    att = CampAttendance.find payed
    att.payed = true
    att.save!
  end
  redirect_to :action => 'index'  
end

def index
  @users = User.all.order :part_id, :family_name_pron, :name_pron
end

end
