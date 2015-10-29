class JobApplicationsController < ApplicationController
  before_action :authenticate_jobseeker_user!,only: [:index,:new,:show, :edit, :update, :destroy]

  before_action :set_job_application, only: [:show, :edit, :update, :destroy]

  # GET /job_applications
  # GET /job_applications.json
  def index

    @job_applications = JobApplication.where(jobseeker_id: session['jobseeker']).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)

  end

  # GET /job_applications/1
  # GET /job_applications/1.json
  def show
  end

  # GET /job_applications/new
  def new
    @job_application = JobApplication.new
  end

  # GET /job_applications/1/edit
  def edit
  end

  # POST /job_applications
  # POST /job_applications.json
  def create
    @job_application = JobApplication.new(job_application_params)

    respond_to do |format|
      if @job_application.save
        format.html { redirect_to @job_application, notice: 'Job application was successfully created.' }
        format.json { render :show, status: :created, location: @job_application }
      else
        format.html { render :new }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_applications/1
  # PATCH/PUT /job_applications/1.json
  def update
    respond_to do |format|
      if @job_application.update(job_application_params)
        format.html { redirect_to @job_application, notice: 'Job application was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_application }
      else
        format.html { render :edit }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  #def contact_candidate
    #job=JobApplication.find(params[:job_application_id])
    #j=Jcontact.new
    #j.job_application_id=job.id
    #j.message=params[:message]
    #j.employer_id=session['employer']
    #if j.save
      #render :text=> 'Message Sent', content_type: 'text/plain'
    #else
      #render :text=> 'Error', content_type: 'text/plain'
    #end
  #end

  # DELETE /job_applications/1
  # DELETE /job_applications/1.json
  def destroy
    @job_application.destroy
    respond_to do |format|
      format.html { redirect_to job_applications_url, notice: 'Job application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

def update_status
  j=JobApplication.find(params[:id])
  if params[:status]
  j.status=params[:status]
    #Notification.create(user_id: j.user_details.id, url: "#{request.protocol}#{request.host}:#{request.port}/job_applications", n_type: 'Applied Application Status')
  Notification.create(user_id: j.user_details.id, url: "#{request.base_url}/job_applications", n_type: 'Applied Application Status')
  else
  j.contact = params[:contact]
  end
  j.save
  render :text=>'ok'

end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      @job_application = JobApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_application_params
      params.require(:job_application).permit(:job_id, :jobseeker_id, :status )
    end
end
