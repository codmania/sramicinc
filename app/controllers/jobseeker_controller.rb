class JobseekerController < ApplicationController
  before_action :authenticate_jobseeker_user!
  def index
  end
    # @res=Job.search do
    #    with(:location_latlon).in_radius(16, 80,100)
    #     with(:address, 'RingRoad')
    # end

    #redirect_to jprofiles_path


    def message_list
    @jobapplication = JobApplication.where(jobseeker_id: session['jobseeker'])
    @jobseeker_messages=Jcontact.where(job_application_id: @jobapplication.pluck(:id)).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end



end
