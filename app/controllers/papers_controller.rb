class PapersController < ApplicationController
  before_action :set_activity, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_paper, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,only: [:index, :new]
  # before_action :require_current_user, only: [:show,:edit]


  # GET /papers
  # GET /papers.json
  def index
    # @papers = @activity.papers.where(user_id: current_user.id)
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
  end

  # GET /papers/new
  def new
    if URI.parse(request.referrer.to_s).path != "/activities/#{@activity.id}"
      redirect_to @activity

    end

    @paper = Paper.new
  end

  # GET /papers/1/edit
  def edit
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = @activity.papers.new(paper_params)
    @paper.user_id = current_user.id
    @paper.users << current_user
    respond_to do |format|
      if @paper.save!
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

    def set_activity
      @activity = Activity.find(params[:activity_id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:paper).permit(:title, :abstract, :outline, :file_name, :status, :activity_id,:inviting_email)

    end
end
