class JobApiController < ApplicationController
  skip_filter :authenticate_user!, only: [:index, :get_all_jobs, :get_job]

  def index

    @employer = Employer.find_by(id: session[:employer])
  end

  def get_all_jobs

    if params[:employer]

      employer =Employer.find_by(id: params[:employer])

      if !employer.nil?
           @jobs = employer.jobs
           status = 'success'
      else
        status = 'failure, There is no Employer with this details'
      end

    else
      status = 'failure, Please request with correct format'

    end

    respond_to do |format|
      #format.json {render :json=>@jobs, status: :status}
      format.json {render json: {
      jobs: @jobs, status: status}}
      format.html{
        render :text => 'Please make a correct request using JSON '
      }

    end

  end


  def get_job

    if params[:employer] && params[:job]

      employer =Employer.find_by(id: params[:employer])

      if !employer.nil?
        @job = Job.find_by(employer: params[:employer], id: params[:job])
        if !@job.nil?
          status = 'success'
        else
          status = 'failure, There is no Job with this details'
        end

      else
        status = 'failure, There is no Employer with this details'
      end

    else
      status = 'failure, Please request with correct format'

    end

    respond_to do |format|
      format.json {render json: {
                              job: @job, status: status}}
      format.html{
        render :text => 'Please make a correct request using JSON '
      }

    end

  end
end
