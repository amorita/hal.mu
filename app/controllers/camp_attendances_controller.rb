class CampAttendancesController < ApplicationController
layout 'priv'
def edit
  @camp_att = CampAttendance.where(:user_id => current_user).first
  if @camp_att.nil?
    @camp_att = CampAttendance.new
    @camp_att.user_id = current_user.id
  end
end

def create
  p hoge.hoge
end

end
