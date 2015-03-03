class PracticePlnsController < ApplicationController
  before_action :set_practice_pln, only: [:show, :edit, :update, :destroy]

  # GET /practice_plns
  # GET /practice_plns.json
  def index
    @practice_plns = PracticePln.where("pln_date > curdate() - 1", :include => [:practice_mode, :practice_place]).order(:pln_date, :begining, :mode)
  end
  
  def all_plns
    @practice_plns = PracticePln.where("pln_date > curdate() - 1", :include => [:practice_mode, :practice_place]).order(:pln_date, :begining, :mode)
    render :partial => "all_plns"
  end

  def next 
    #直近の予定のみ
    tmp = PracticePln.where("pln_date > curdate() - 1", :include => [:practice_mode, :practice_place]).order(:pln_date, :begining, :mode)
    date = tmp[0].pln_date
    @practice_plns = PracticePln.where(:pln_date => date).order(:pln_date, :begining, :mode)
    render :partial => "next"
  end
  # GET /practice_plns/1
  # GET /practice_plns/1.json
  def show
  end

  def mail_notif
    @practice_pln = PracticePln.where(:id => params[:id]).first
  end
  # GET /practice_plns/new
  def new
    @practice_pln = PracticePln.new
  end

  # GET /practice_plns/1/edit
  def edit
  end

  # POST /practice_plns
  # POST /practice_plns.json
  def create
    @practice_pln = PracticePln.new(practice_pln_params)
    @practice_pln.uuid = SecureRandom.uuid
    respond_to do |format|
      if @practice_pln.save
        format.html { redirect_to @practice_pln, notice: 'Practice pln was successfully created.' }
        format.json { render action: 'show', status: :created, location: @practice_pln }
      else
        format.html { render action: 'new' }
        format.json { render json: @practice_pln.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practice_plns/1
  # PATCH/PUT /practice_plns/1.json
  def update
    respond_to do |format|
      if @practice_pln.update(practice_pln_params)
        format.html { redirect_to @practice_pln, notice: 'Practice pln was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @practice_pln.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_sendmail
    @practice_pln = PracticePln.where(:id => params[:id]).first
    respond_to do |format|
      if @practice_pln.update(practice_pln_params)
        RehearsalNotif.notif(@practice_pln, params).deliver
        format.html { redirect_to @practice_pln, notice: 'メールを送信しました！' }
        format.json { head :no_content }
      else
        format.html { render action: 'mail_notif' }
        format.json { render json: @practice_pln.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practice_plns/1
  # DELETE /practice_plns/1.json
  def destroy
    @practice_pln.destroy
    respond_to do |format|
      format.html { redirect_to practice_plns_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice_pln
      @practice_pln = PracticePln.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_pln_params
      params.require(:practice_pln).permit(:practice_pln,:pln_date, :room, :begining, :ending, :description, :mode, :place, :header_text, :footer_text)
    end
end
