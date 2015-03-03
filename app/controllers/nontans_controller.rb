class NontansController < ApplicationController
  before_action :set_nontan, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /nontans
  # GET /nontans.json
  def index
    @plns = PracticePln.where('pln_date > curdate() - 1').order(:pln_date)
  end

  def index2
    @plns = PracticePln.where('pln_date > now()').order(:pln_date)
  end

  def mail_notif
  end
  # GET /nontans/1
  # GET /nontans/1.json
  def show
  end

  # GET /nontans/new
  def new
    @nontan = Nontan.new
  end

  # GET /nontans/1/edit
  def edit
  end
  
  def intro
  end

  # POST /nontans
  # POST /nontans.json
  def create
    p nontan_params
    @nontan = Nontan.new(nontan_params)

    respond_to do |format|
      if @nontan.save
        format.html { redirect_to nontans_url }
        format.json { render action: 'show', status: :created, location: @nontan }
      else
        format.html { render action: 'new' }
        format.json { render json: @nontan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nontans/1
  # PATCH/PUT /nontans/1.json
  def update
    respond_to do |format|
      if @nontan.update(nontan_params)
        format.html { redirect_to nontans_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @nontan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nontans/1
  # DELETE /nontans/1.json
  def destroy
    @nontan.destroy
    respond_to do |format|
      format.html { redirect_to nontans_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nontan
      @nontan = Nontan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nontan_params
      params.require(:nontan).permit(:practice_pln_id, :part_id, :user_name, :subs_name, :reason, :time, :nontan_class_id)
    end
end
