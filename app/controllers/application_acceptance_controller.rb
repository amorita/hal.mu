# -*- coding: utf-8 -*-
class ApplicationAcceptanceController < ApplicationController

before_filter :authenticate_user!
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
		ApplicationMail.somu(@app.id).deliver
	    redirect_to :action => 'president_index', notice: 'successfully updated.'
  	else
    	render action: 'edit'
  	end
end

def somu_index
	@apps = Application.where('somu_accepted_at is null and president_accepted_at is not null')
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
	    redirect_to :action => 'somu_index', notice: 'successfully updated.'
  	else
    	render action: 'edit'
  	end
end

  def absence_new
    @app = Application.new
    @app.application_type = 'absence'
    @app.ends_at = Concert.where('date > now()').order(:date).first.date
    @app.user_id = current_user.id
    render 'new'
  end

  def retire_new
    @app = Application.new
    @app.application_type = 'retire'
    @app.user_id = current_user.id
    render 'new'
  end

  def create
    @app = Application.new(app_params)
    unless params['agree']
      @app.errors[:base] << '同意条項への同意が必要です。'
    end

	if @app.save
	  ApplicationMail.notification(app.id).deliver
	  format.html { render 'sent' }
	else
	  format.html { render 'new' }
	end

  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:application).permit(:starts_at, :ends_at, :part_memo, :user_memo, :part_memo, :somu_memo)
    end

end
