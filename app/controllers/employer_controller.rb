class EmployerController < ApplicationController
  # layout 'employer'
  skip_before_action :authenticate_user!, only:[:talents,:company_talents]
  before_action :authenticate_employer_user!,except:[:talents,:company_talents]

 def index

 end

 def my_jobs
   @jobs=Employer.find(session[:employer]).jobs.where(deleted: false).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
 end

  def job_applications
  	@job=Job.find(params[:id])
    @jobapp=JobApplication.where(:job_id=>@job).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

 def talents
   @jprofile=Jprofile.find(params[:id])
   @educations = Education.where(jprofile_id: @jprofile.id)
   @job_histories = JobHistory.where(jprofile_id: @jprofile.id)
   @certifications = Certification.where(jprofile_id: @jprofile.id)
   @journals= Journal.where(jprofile_id: @jprofile.id)
   @skills = Skill.where(jprofile_id: @jprofile.id)
   @hired_profile = ProfileHire.find_by(employer_id: session['employer'],jprofile_id: params[:id])
   @reviews=Review.where(:to=> @jprofile.jobseeker.user.id)
     

  end


    def hire_candidate
    p=ProfileHire.new
    p.employer_id=session['employer']
    p.jprofile_id=params[:jprofile_id]
    p.save


    str =''
    if params[:offset]=='1'
      str = ApplicationHelper.params_constructions_jprofile(params)
    end


    respond_to do |format|
      format.html{
        redirect_to employer_talents_path(:id => params[:jprofile_id])+str, :flash => {:notice => 'Hired Profile'}
      }
      format.json {render :json=>'Hired Profile'}
    end


  end


  def review_list
    @reviews=Review.where(employer_id: session['employer']).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  def contact_candidate
    job=JobApplication.find(params[:job_application_id])
    j=Jcontact.new
    j.job_application_id=job.id
    j.message=params[:message]
    j.employer_id=session['employer']
    if j.save
      render :text=> 'Message Sent', content_type: 'text/plain'
    else
      render :text=> 'Error', content_type: 'text/plain'
    end
  end
  
  def summary
    @employer = Employer.find(session[:employer])
    @jobs = Job.where(employer_id: @employer)
    @jobapp = JobApplication.where(job_id: @jobs)
    @reviews=Review.where(to: @employer.user.id)
    @jobapp_recent = JobApplication.where(job_id: @jobs, created_at: (current_user.last_sign_in_at)..Time.now)
    @networks= Network.where(me: session[:employer])
    @subscribed=0
    @comments= Comment.where(job_id: @jobs)
    @comments_recent= Comment.where(job_id: @jobs,created_at: (current_user.last_sign_in_at)..Time.now)
    @visitors = 0
    @visitors_recent = 0


  end


    def addtobookmark
   	puts params[:id]

   	@jprofile = Jprofile.find(params[:id])
    # @jobseeker = Jobseeker.find(params[:id])
    puts session['employer']
    @bookmark = Bookmark.find_by(jobseeker_id: @jprofile.jobseeker_id, employer_id: session['employer'])


    if @bookmark.nil?
      @bookmark1 = Bookmark.new(jobseeker_id: params[:id], employer_id: session['employer'])
      if @bookmark1.save
        message = 'Added Jobseeker Successfully in your Bookmark'
      else
        message = 'Something wrong while Adding this Jobseeker in your Bookmark'
      end
    else
      message = 'You already Added this Jobseeker in your Bookmark'
    end

    str =''
    if params[:offset]=='1'
      str = ApplicationHelper.params_constructions_jprofile(params)
    end

     respond_to do |format|
       format.html { redirect_to employer_talents_path(:id => params[:id])+str, flash: { notice: message } }
     end

  end


  def contact
    @jprofile=Jprofile.find_by(params[:jid])
      sub = params[:subject]
      @mess = params[:message][0]
      email = params[:email2]
    EmployerMailer.send_email(sub,@mess,email).deliver_later
    render :text => 'Message Sent sucessfully..', content_type: 'text/plain'

    end

    private
    def review_params
    params.require(:employer_review).permit(:contents)
    end

end
