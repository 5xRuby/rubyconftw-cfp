class PapersController < ApplicationController
  before_action :current_activity, if: lambda{params.has_key?(:activity_id)}
  before_action :set_paper, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,only: [:index, :new]
  # before_action :require_current_user, only: [:show,:edit]


  # GET /papers
  # GET /papers.json
  def index
     @papers = @activity.papers.where(user_id: current_user.id)
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
    @user = @paper.user
    @invited_user = User.find_by_email(@paper.inviting_email)
  end

  # GET /papers/new
  def new
    @paper = current_user.papers.new
  end

  # GET /papers/1/edit
  def edit
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = @activity.papers.new(paper_params)
    @paper.user = current_user
    logger.info @paper.inspect
    respond_to do |format|
      if @paper.save
        format.html { redirect_to activity_paper_path(@activity, @paper), notice: 'Paper was successfully created.' }
      else
        format.html {
          render :new}
      end
    end
  end

  # PATCH/PUT /papers/1
  # PATCH/PUT /papers/1.json
  def update
    respond_to do |format|
      if @paper.update(paper_params)
        format.html { redirect_to activity_paper_path(@activity, @paper), notice: 'Paper was successfully updated.' }
        format.json { render :show, status: :ok, location: @paper }
      else
        format.html { render :edit }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper.destroy
    respond_to do |format|
      format.html { redirect_to activity_papers_path(@activity), notice: 'Paper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = Paper.find(params[:id])
    end

    def current_activity
      @activity ||= Activity.find(params[:activity_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      paper_params = params.require(:paper).permit(:pitch, :speaker_bio, :title, :abstract, :outline, :file_name, :status, :activity_id,:inviting_email, answer_of_custom_fields: current_activity.custom_fields.map{|x| x.id.to_s} )
      paper_params.permit!

    end
end
