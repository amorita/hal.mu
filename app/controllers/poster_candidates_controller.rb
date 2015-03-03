class PosterCandidatesController < ApplicationController
  before_action :set_poster_candidate, only: [:show, :edit, :update, :destroy]

  # GET /poster_candidates
  # GET /poster_candidates.json
  def index
    @poster_candidate = PosterCandidate.new
  end

  # GET /poster_candidates/1
  # GET /poster_candidates/1.json
  def show
  end

  # GET /poster_candidates/new
  def new
    @poster_candidate = PosterCandidate.new
  end

  # GET /poster_candidates/1/edit
  def edit
  end

  # POST /poster_candidates
  # POST /poster_candidates.json
  def create
    @poster_candidate = PosterCandidate.new(poster_candidate_params)
    @poster_candidate.mail = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    respond_to do |format|
      if @poster_candidate.save
        format.html { redirect_to @poster_candidate, notice: 'Poster candidate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @poster_candidate }
      else
        format.html { render action: 'new' }
        format.json { render json: @poster_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /poster_candidates/1
  # PATCH/PUT /poster_candidates/1.json
  def update
    respond_to do |format|
      if @poster_candidate.update(poster_candidate_params)
        format.html { redirect_to @poster_candidate, notice: 'Poster candidate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poster_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poster_candidates/1
  # DELETE /poster_candidates/1.json
  def destroy
    @poster_candidate.destroy
    respond_to do |format|
      format.html { redirect_to poster_candidates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poster_candidate
      @poster_candidate = PosterCandidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poster_candidate_params
      params.require(:poster_candidate).permit(:selection, :mail, :user_id)
    end
end
