require 'securerandom'

class SharedfilesController < ApplicationController
  before_action :set_sharedfile, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  layout false

  # GET /sharedfiles
  # GET /sharedfiles.json
  def index
    @sharedfiles = Sharedfile.where('created_at >= DATE_ADD(NOW(), INTERVAL -1 MONTH)')
  end

  # GET /sharedfiles/1
  # GET /sharedfiles/1.json
  def show
  end

  # GET /sharedfiles/new
  def new
    @sharedfile = Sharedfile.new
    render :partial => "form"
  end

  # GET /sharedfiles/1/edit
  def edit
  end

  # POST /sharedfiles
  # POST /sharedfiles.json
  def create
    file = sharedfile_params[:file]
    name = file.original_filename
    dir = SecureRandom.hex(16)
    `mkdir /home/yu/rails/hal/public/sharedfiles/#{dir}`
    File.open("/home/yu/rails/hal/public/sharedfiles/" + dir + "/" + name, 'wb') { |f|
      f.write(file.read)
    }
    @sharedfile = Sharedfile.new

    @sharedfile.name = sharedfile_params[:name]
    @sharedfile.description = sharedfile_params[:description]
    @sharedfile.file_category_id = sharedfile_params[:file_category_id]
    @sharedfile.user_id = current_user.id
    @sharedfile.filepath = dir + "/" + name
    
    respond_to do |format|
      if @sharedfile.save
        format.html { redirect_to :controller => 'main', :action => 'index', notice: 'ファイルを正常にアップロードしました！' }
        format.json { render action: 'show', status: :created, location: @sharedfile }
      else
        format.html { render action: 'new' }
        format.json { render json: @sharedfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sharedfiles/1
  # PATCH/PUT /sharedfiles/1.json
  def update
    respond_to do |format|
      if @sharedfile.update(sharedfile_params)
        format.html { redirect_to @sharedfile, notice: 'Sharedfile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sharedfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sharedfiles/1
  # DELETE /sharedfiles/1.json
  def destroy
    @sharedfile.destroy
    respond_to do |format|
      format.html { redirect_to sharedfiles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sharedfile
      @sharedfile = Sharedfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sharedfile_params
      params.require(:sharedfile).permit(:filepath, :description, :file_category_id, :uploader, :name, :file)
    end
end
