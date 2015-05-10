# -*- coding: utf-8 -*-
class PersonalDataController < ApplicationController

before_filter :authenticate_user!

layout 'priv'

  def index
    @personal_data = nil    
  end

# GET /tests/1/edit
  def edit
  	@personal_data = PersonalData.where(:id => current_user.id).first
  end

  def show
  	@personal_data = PersonalData.where(:id => current_user.id).first
  end

  def new
    @personal_data = PersonalData.new
  end

  def join
    @personal_data = PersonalData.where(:id => current_user.id).first
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    @personal_data = PersonalData.where(:id => current_user.id).first
    respond_to do |format|
      if @personal_data.update(personal_data_params)
        format.html { redirect_to @personal_data, notice: 'Test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @personal_data.errors, status: :unprocessable_entity }
      end
    end
  end

  def join_process
    @personal_data = PersonalData.where(:id => current_user.id).first
    @personal_data.assign_attributes(personal_data_params)
    p @personal_data
    unless params['agree']
      @personal_data.errors[:base] << '同意条項への同意が必要です。'
    end
    if !@personal_data.worker && @personal_data.school.length < 4
      @personal_data.errors.add :school, '学生の場合は学校名の入力が必要です。'
    end
    if @personal_data.errors.any?
      render 'join' and return
    end
    respond_to do |format|
      if @personal_data.update(personal_data_params)
        # 申請データの作成
        app = Application.new
        app.user_id = current_user.id
        app.application_type = 'join'
        app.starts_at = Date.today
        app.save!

        # 提出通知送信
        ApplicationMail.notification(app.id).deliver

        format.html { redirect_to :controller => 'main', :action => 'index', notice: '入団届けの提出が完了しました。' }
      else
        format.html { render 'join' and return}
      end
    end


  end




  def create
    @personal_data = PersonalData.new(personal_data_params)

    unless current_user.admin
      @personal_data.part_id = current_user.part_id
    end
    @personal_data.initial_access_token = format('%06d', rand(1000000))

    respond_to do |format|
      if @personal_data.save
        WelcomeMail.welcome(@personal_data.id).deliver
        format.html { render 'registered' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
  def personal_data_params
      params.require(:personal_data).permit(:family_name, :name, :family_name_pron, :name_pron, :nickname, :part_id, :email, :phone, :zip_code, :address, :building, :worker, :school);
  end

end
