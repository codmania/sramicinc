class JobAlertsController < ApplicationController
  before_action :authenticate_jobseeker_user!
  before_action :set_job_alert, only: [:show, :edit, :update, :destroy]

  # GET /job_alerts
  # GET /job_alerts.json
  def index
    @job_alerts = JobAlert.all
  end

  # GET /job_alerts/1
  # GET /job_alerts/1.json
  def show
  end

  # GET /job_alerts/new
  def new
    @job_alert = JobAlert.new
  end

  # GET /job_alerts/1/edit
  def edit
  end

  # POST /job_alerts
  # POST /job_alerts.json
  def create
    @job_alert = JobAlert.new(job_alert_params)

    respond_to do |format|
      if @job_alert.save
        format.html { redirect_to job_alerts_path, notice: 'Job alert was successfully created.' }
        format.json { render :show, status: :created, location: @job_alert }
      else
        format.html { render :new }
        format.json { render json: @job_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_alerts/1
  # PATCH/PUT /job_alerts/1.json
  def update
    respond_to do |format|
      if @job_alert.update(job_alert_params)
        format.html { redirect_to job_alerts_path, notice: 'Job alert was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_alert }
      else
        format.html { render :edit }
        format.json { render json: @job_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_alerts/1
  # DELETE /job_alerts/1.json
  def destroy
    @job_alert.destroy
    respond_to do |format|
      format.html { redirect_to job_alerts_url, notice: 'Job alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_alert
      @job_alert = JobAlert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_alert_params
      params.require(:job_alert).permit(:what, :where, :within, :user_id)
    end
end
