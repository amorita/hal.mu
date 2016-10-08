# -*- coding: utf-8 -*-
class ApplicationAcceptanceController < ApplicationController

include GoogleDirectoryApi

#protect_from_forgery except: :absence_new
before_filter :authenticate_user!
skip_before_filter :verify_authenticity_token
layout 'priv'

def index
	if current_user.admin
		@apps = Application.where('part_accepted_at is null')
	else
		@apps = Application.where('part_accepted_at is null and user_id in (select id from users where part_id = ?)', current_user.part_id)
	end
end

def edit
	@app = Application.find params[:id]
end

def part_accept
	p params
	@app = Application.find params[:id]
	@app.assign_attributes(app_params)
	@app.part_accepted_at = Date.today
	@app.part_user_id = current_user.id

	if @app.save
		ApplicationMail.president(@app.id).deliver
	    redirect_to :action => 'index', notice: 'successfully updated.'
  	else
    	render action: 'edit'
  	end
end


def president_index
  @apps = Application.where('president_accepted_at is null and part_accepted_at is not null')
end

def president_edit
  @app = Application.find params[:id]
end

def president_accept
  p params
  @app = Application.find params[:id]
  @app.assign_attributes(app_params)
  @app.president_accepted_at = Date.today

  if @app.save
    ApplicationMail.accountant(@app.id).deliver
      redirect_to :action => 'president_index', notice: 'successfully updated.'
    else
      render action: 'edit'
    end
end

def accountant_index
  @apps = Application.all.order('id DESC')
end

def accountant_edit
  @app = Application.find params[:id]
  @user = PersonalData.find @app.user_id
end

def accountant_accept
  p params
  @app = Application.find params[:id]
  @app.assign_attributes(app_params)
  @app.accountant_accepted_at = Date.today

  if @app.save
    ApplicationMail.somu(@app.id).deliver
      redirect_to :action => 'accountant_index', notice: 'successfully updated.'
    else
      render action: 'edit'
    end
end

def somu_index
	@apps = Application.all.order('id DESC')
end

def somu_edit
	@app = Application.find params[:id]
end

def somu_accept
	p params
	@app = Application.find params[:id]
	@app.assign_attributes(app_params)
	@app.somu_accepted_at = Date.today
	if @app.save
    proc_apps(@app)
    redirect_to :action => 'somu_index', notice: 'successfully updated.'
	else
  	render action: 'edit'
	end
end

  def absence_init
    concerts = Concert.where('date > now()').order(:date)
    @options = []
    concerts.each do |c|
      pre = Concert.find c.id - 1
      node = []
      node << "第#{c.id.to_s}回定期演奏会期間 #{(pre.date + 1).strftime('%Y/%m/%d')} 〜 #{c.date.strftime('%Y/%m/%d')}"
      node << c.id
      @options << node
    end
    @dates = []
    d = Concert.find(concerts[0].id - 1).date
    8.times do
      d = d >> 1
      node = []
      node << d.strftime('%Y年%m月')
      node << d.year.to_s + ',' +  format("%02d", d.month)
      @dates << node
    end
  end

  def absence_new
    @app = Application.new
    @app.application_type = 'absence'

    c = Concert.find params[:absence_term_id]
    pre = Concert.find params[:absence_term_id].to_i - 1
    date_param = params[:starts_at].split ','
    @start_date = Date.new date_param[0].to_i, date_param[1].to_i, 1
    @end_date = c.date
    if @start_date < pre.date then 
      redirect_to( :back )
      return
    end

    @app.starts_at = @start_date
    @app.ends_at = c.date
    @app.user_id = current_user.id
    render 'new'
  end

  def retire_new
    @app = Application.new
    @app.application_type = 'retire'
    @app.user_id = current_user.id
    render 'new'
  end

  def return_new
    @app = Application.new
    @app.application_type = 'return'
    @app.user_id = current_user.id
    render 'new'
  end    

  def create
    @app = Application.new(app_params)
    if @app.application_type == 'absence'
    	@app.ends_at = Concert.where('date > now()').order(:date).first.date
    end
    unless params['agree']
      @app.errors[:base] << '同意条項への同意が必要です。'
    end

	if @app.save
	  ApplicationMail.notification(@app.id).deliver
	  render 'sent' and return
	else
	  render 'new' and return
	end

  end


  def create_monthly_fees(app)
    # 承認情報を元にして支払予定を作成する
    user = app.user
    practice_modes = app.user.part_id < 100 ? [1, 2, 10, 20] : [1, 3, 10, 20]
    last_rehearsal = PracticePln.where("pln_date <= '#{app.starts_at.strftime('%Y/%m/%d')}'").where(:mode => practice_modes).order('pln_date DESC').first
    next_rehearsal = PracticePln.where("pln_date >= '#{app.starts_at.strftime('%Y/%m/%d')}'").where(:mode => practice_modes).order(:pln_date).first
    unless app.ends_at.nil?
      end_next_rehearsal = PracticePln.where("pln_date > '#{app.ends_at.strftime('%Y/%m/%d')}'").where(:mode => practice_modes).order(:pln_date).first
    end

    start_year = last_rehearsal.pln_date.year

    case app.application_type
    when 'absence'
      range = (last_rehearsal.pln_date.month + 1)..(end_next_rehearsal.pln_date.month - 1)
      start_year = last_rehearsal.pln_date.year
    when 'return', 'join'
      range = next_rehearsal.pln_date.month..(next_rehearsal.pln_date.month + 12)
      start_year = next_rehearsal.pln_date.year
    end

    if app.application_type == 'join'
      # 繰越情報の作成、エラーの回避
      trans = AccountTransaction.new
      trans.user_id = app.user_id
      trans.amount = 0
      trans.transaction_type = 'carryover'
      trans.posted_at = FeeCutoff.all.order('cutoff_date desc').first.cutoff_date + 1
      trans.save!

      monthly_fee = MonthlyFee.new 
      monthly_fee.year = Date.today.year
      monthly_fee.month = Date.today.month
      monthly_fee.user_id = app.user.id
      monthly_fee.save!
    end

    for month in range do
      # 対象の年月を取得
      if month > 12
        month = month - 12
        year = start_year + 1
      else
        year = start_year
      end

      monthly_fee = MonthlyFee.where(:user_id => user.id, :year => year, :month => month).first
      if monthly_fee.nil?
        monthly_fee = MonthlyFee.new 
        monthly_fee.year = year
        monthly_fee.month = month
        monthly_fee.user_id = app.user.id
      end

      date_str = year.to_s + '/' + month.to_s + '/01'
      fee = FeeAmount.where("starts_at < '#{date_str}' and ends_at > '#{date_str}'").first
      if app.user.worker
        case app.application_type
        when 'absence'
          monthly_fee.amount = fee.workers / 2
          monthly_fee.is_absent = true
        when 'return', 'join'
          monthly_fee.amount = fee.workers
        end
      else
        case app.application_type
        when 'absence'
          monthly_fee.amount = fee.students / 2
          monthly_fee.is_absent = true
        when 'return', 'join'
          monthly_fee.amount = fee.students
        end
      end
      monthly_fee.save!
    end      
  end


  def proc_apps(app)
    if app.application_type == 'retire'
      proc_retire(app)
    else
      create_monthly_fees(app)
    end
    proc_ml(nil, nil, app.user) if app.application_type == 'join'
  end

  def proc_retire(app)
    #退団処理
    user = User.find app.user_id
    user.retired = true
    user.save!
    #団費予定
    MonthlyFee.destroy_all('user_id = ' + app.user_id.to_s + ' and year >= ' + app.ends_at.year.to_s + ' and month > ' + app.ends_at.month.to_s)
    return 0
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:application).permit(:starts_at, :ends_at, :part_memo, :user_memo, :part_memo, :somu_memo, :user_id, :application_type)
    end

end
