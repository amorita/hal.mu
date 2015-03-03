class EnqAnswersController < ApplicationController
  before_action :set_enq_answer, only: [:show, :edit, :update, :destroy]

  # GET /enq_answers
  # GET /enq_answers.json
  def index
    @enq_answers = EnqAnswer.all
  end

  # GET /enq_answers/1
  # GET /enq_answers/1.json
  def show
  end

  # GET /enq_answers/new
  def new
    @enq_answer = EnqAnswer.new
  end

  # GET /enq_answers/1/edit
  def edit
  end

  # POST /enq_answers
  # POST /enq_answers.json
  def create
    @enq_answer = EnqAnswer.new(enq_answer_params)

    respond_to do |format|
      if @enq_answer.save
        format.html { redirect_to @enq_answer, notice: 'Enq answer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @enq_answer }
      else
        format.html { render action: 'new' }
        format.json { render json: @enq_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enq_answers/1
  # PATCH/PUT /enq_answers/1.json
  def update
    respond_to do |format|
      if @enq_answer.update(enq_answer_params)
        format.html { redirect_to @enq_answer, notice: 'Enq answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @enq_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enq_answers/1
  # DELETE /enq_answers/1.json
  def destroy
    @enq_answer.destroy
    respond_to do |format|
      format.html { redirect_to enq_answers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enq_answer
      @enq_answer = EnqAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enq_answer_params
      params.require(:enq_answer).permit(:enq_gender_id, :enq_age_id, :enq_time_req_id, :enq_district_id, :enq_source_id, :memo, :concert_no)
    end
end
