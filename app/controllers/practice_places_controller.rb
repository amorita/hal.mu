class PracticePlacesController < ApplicationController
  before_action :set_practice_place, only: [:show, :edit, :update, :destroy]

  # GET /practice_places
  # GET /practice_places.json
  def index
    @practice_places = PracticePlace.all.order :id
  end

  # GET /practice_places/1
  # GET /practice_places/1.json
  def show
  end

  # GET /practice_places/new
  def new
    @practice_place = PracticePlace.new
  end

  # GET /practice_places/1/edit
  def edit
  end

  # POST /practice_places
  # POST /practice_places.json
  def create
    @practice_place = PracticePlace.new(practice_place_params)

    respond_to do |format|
      if @practice_place.save
        format.html { redirect_to practice_places_path }
        format.json { render action: 'show', status: :created, location: @practice_place }
      else
        format.html { render action: 'new' }
        format.json { render json: @practice_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practice_places/1
  # PATCH/PUT /practice_places/1.json
  def update
    respond_to do |format|
      if @practice_place.update(practice_place_params)
        format.html { redirect_to practice_places_path }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @practice_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practice_places/1
  # DELETE /practice_places/1.json
  def destroy
    @practice_place.destroy
    respond_to do |format|
      format.html { redirect_to practice_places_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice_place
      @practice_place = PracticePlace.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_place_params
      params.require(:practice_place).permit(:place_name, :description, :url, :map_url, :show_flg, :address)
    end
end
