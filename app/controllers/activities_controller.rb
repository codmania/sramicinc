class ActivitiesController < ApplicationController
  before_action :authenticate_jobseeker_user!
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @jobseeker = Jobseeker.find(session[:jobseeker])
    @jobapp = JobApplication.where(jobseeker_id: @jobseeker)
    @networks= Network.where(me: session[:employer])
    @jobapp = JobApplication.where(jobseeker_id: @jobseeker )
    if @jobapp.present?
      @newjobs = Job.where(created_at: (@jobapp.try(:last).try(:created_at))..Time.now)
    else
      @newjobs = Job.all
    end
    @views = 0
    @views_recent = 0
    @contat = Jcontact.where(job_application_id: @jobapp)
    @contact_recent = Jcontact.where(job_application_id: @jobapp, created_at: (current_user.last_sign_in_at)..Time.now)
    @reviews=Review.where(to: @jobseeker.user.id)
      @reviews_recent = Review.where(to: @jobseeker.user.id, created_at:(current_user.last_sign_in_at)..Time.now)
    #@activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:activity)
    end
end
