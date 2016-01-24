# require "FasterCSV"

class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only:[:show,:job_eprofile]
  before_action :set_user, only: [:create, :edit, :update, :destroy, :new]
  before_action :check_valid_user, only: [:edit, :update, :destroy], if: "current_user.role.authority != 'admin'"


  #before_action :user_subscription_validate_job_post!, only:[:new, :create],  if: :payment_module_activated



  require 'date'

  def new
    @job = Job.new
  end

  def edit
    @job=Job.find params[:id]
  end

  def create
    puts 'create....' + params.inspect
    puts 'create....' + params[:file].to_s
    if params[:file].nil?
      @job = Job.new(job_params)
      @job.employer_id = @employer.id
      respond_to do |format|
        if @job.save
          format.html { redirect_to @job, notice: 'Job was successfully created.' }
          format.json { render :show, status: :created, location: @job }
        else
          format.html { render :new }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
      end
    else
      puts 'create3....' + params[:file].to_s
      CSV.foreach( params[:file].path, :headers           => true,
                   :header_converters => :symbol,
                   :converters        => :numeric ) do |row|
        j1=Job.new
        j1.title=row[0]
        j1.employer_id=session[:employer]
        j1.keywords=row[1]
        j1.city=row[2]
        j1.state_list_id=row[3]
        j1.country_list_id=row[4]
        j1.zip=row[5]
        j1.industry_id=row[6]
        j1.category_id=row[7]
        j1.experience=row[8]
        j1.education=row[9]
        j1.relocation=row[10]
        j1.salary_type_id=row[11]
        j1.salary=row[12]
        #j1.job_length=row[13]
        j1.job_type_id=row[14]
        j1.certification=row[15]
        j1.references=row[16]
        j1.description=row[17]
        j1.clearance=row[18]

        puts 'from csv '+j1.inspect
        j1.save
        puts 'csv each ...'+row[0].to_s
      end #do
      respond_to do |format|
        format.html { redirect_to my_jobs_path, notice: 'Jobs was successfully uploaded.' }
        # format.json { render :show, status: :created, location: @job }
      end
    end #else
  end

  def update
    @job=Job.find params[:id]
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job=Job.find params[:id]
    @job.deleted = true
    @job.save
    respond_to do |format|
      format.html { redirect_to my_jobs_path, notice: 'Job Was Successfully Deleted.' }
      format.json { head :no_content }
    end
  end

  def show
    @job = Job.find(params[:id])
    puts 'job....'+@job.to_s
    @eprofile = Eprofile.find_by(employer_id: @job.employer_id)
    @job.employer_id

    place=nil
    @keywords=@job.keywords
    if @job.city.present?
      place = @job.city
    else
      place = @job.zip
    end
    latlon = Geocoder.coordinates(place) if !place.nil?
    @sus = Sunspot.search(Job) do
      job = Job.find(params[:id])
      keyword = params[:keywords].split(/[,\s]+/).map(&:strip).map { |x| x.downcase } if params[:keywords].present?
      with(:plain_description).any_of(keyword) if params[:keywords].present?
      #fulltext job.keywords.split(',').map{|x| x.downcase}
      with(:location_latlon).in_radius(latlon[0],latlon[1], 50) if !place.nil? && !latlon.nil?
      without(:id,job.id)
      paginate page: 1, per_page: 4
    end
    @place=place
    @similarjobs=@sus.results

  end

  def index
    @jobs = []
    if current_user.role.authority == 'employer'
      @jobs = @employer.jobs
    elsif current_user.role.authority == 'admin'
      if  params['where'].present?
        latlon = Geocoder.coordinates(params[:where])
        lat = latlon[0]
        lon = latlon[1]
      else
        lat = 0
        lon = 0
      end
      pdate_start = Time.now
      pdate_end = pdate_start - 1.days
      if params[:postingdate].present?
        pdate_end=pdate_start-1.days  if params[:postingdate]=='Last 24 hours'
        pdate_end=pdate_start-3.days  if params[:postingdate]=='Last 3 days'
        pdate_end=pdate_start-7.days  if params[:postingdate]=='Last 7 days'
        pdate_end=pdate_start-15.days  if params[:postingdate]=='Last 15 days'
        pdate_end=pdate_start-30.days  if params[:postingdate]=='Last 30 days'
      end
      params[:page] = 1 unless params[:page].present?
      params[:per_page]=params[:offset].nil? ? PER_PAGE_COUNT : params[:offset]
      @jobs = Sunspot.search(Job) do
        with(:created_at, pdate_end..pdate_start) if params[:postingdate].present?
        with(:id,params[:id]) if params[:id].present?
        with(:location_latlon).in_radius(lat, lon, 10) if params['where'].present?
        with(:deleted, false)
        paginate(page: params[:page], per_page: params[:per_page])
        order_by(:created_at, :desc)
      end
      #@jobs = Job.all.order('created_at DESC').paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
    end
    respond_to do |format|
      format.html
      format.json { render json: @jobs }
    end
  end

  def archives
    @jobs = []
    if current_user.role.authority == 'employer'
      @jobs = @employer.jobs
    elsif current_user.role.authority == 'admin'
      if  params['where'].present?
        latlon = Geocoder.coordinates(params[:where])
        lat = latlon[0]
        lon = latlon[1]
      else
        lat = 0
        lon = 0
      end
      pdate_start = Time.now
      pdate_end = pdate_start - 1.days
      if params[:postingdate].present?
        pdate_end=pdate_start-1.days  if params[:postingdate]=='Last 24 hours'
        pdate_end=pdate_start-3.days  if params[:postingdate]=='Last 3 days'
        pdate_end=pdate_start-7.days  if params[:postingdate]=='Last 7 days'
        pdate_end=pdate_start-15.days  if params[:postingdate]=='Last 15 days'
        pdate_end=pdate_start-30.days  if params[:postingdate]=='Last 30 days'
      end
      params[:page] = 1 unless params[:page].present?
      params[:per_page]=params[:offset].nil? ? PER_PAGE_COUNT : params[:offset]
      @jobs = Sunspot.search(Job) do
        with(:created_at, pdate_end..pdate_start) if params[:postingdate].present?
        with(:id,params[:id]) if params[:id].present?
        with(:location_latlon).in_radius(lat, lon, 10) if params['where'].present?
        with(:deleted, true)
        paginate(page: params[:page], per_page: params[:per_page])
        order_by(:created_at, :desc)
      end
      #@jobs = Job.all.order('created_at DESC').paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
    end
    respond_to do |format|
      format.html
      format.json { render json: @jobs }
    end
  end

  def addtocart
    @job = Job.find(params[:id])
    @cart = Cart.find_by(job_id: params[:id], jobseeker_id: session['jobseeker'])
    @job_application =  JobApplication.find_by(job_id: params[:id], jobseeker_id: session['jobseeker'])

    if @cart.nil? && @job_application.nil?
      @cart = Cart.new(job_id: params[:id], jobseeker_id: session['jobseeker'])
      if @cart.save
        message = 'Added Job Successfully in your Cart'
      else
        message = 'Something wrong while Adding this Job in your Cart'
      end

    elsif @job_application
      message = 'You already applied for this Job'
    else

      message = 'You already Added this Job in your Cart'
    end

    str =''
    if params[:offset]=='1'
      str = ApplicationHelper.params_constructions_jobs(params)
    end

    respond_to do |format|
      format.html { redirect_to job_path(id: @job.id)+'?'+str, flash: { notice: message } }
      format.json { render :show, location: @job }
    end
  end

  def add_to_watchlist
    @job = Job.find(params[:id])
    @watchList = WatchList.find_by(job_id: params[:id], jobseeker_id: session['jobseeker'])

    if @watchList.nil?
      @watchList = WatchList.new(job_id: params[:id], jobseeker_id: session['jobseeker'])
      if @watchList.save
        message = 'Added Job Successfully in your WatchList'
      else
        message = 'Something wrong while Adding this Job in your WatchList'
      end
    else
      message = 'You already Added this Job in your WatchList'
    end

    str =''
    if params[:offset]=='1'
      str = ApplicationHelper.params_constructions_jobs(params)
    end


    respond_to do |format|
      format.html { redirect_to job_path(id: @job.id)+'?'+str, flash: { notice: message } }
      format.json { render :show, location: @job }
    end
  end

  def apply_job

    @job = Job.find(params[:id])

    if !@job.nil?
      @job_application = JobApplication.find_by(job_id: @job.id, jobseeker_id: session['jobseeker'])

      if @job_application.nil?

        # if its in cart, then while applying we are removing from here
        @cart = Cart.find_by(job_id: @job.id, jobseeker_id: session['jobseeker'])
        @cart.destroy if @cart

        @job_application = JobApplication.new(job_id: @job.id, jobseeker_id: session['jobseeker'])
        if @job_application.save
          Notification.create(user_id: @job.employer.user_id, url: "#{request.base_url}/my_jobs", n_type: 'Job Application')
          @email_template = EmailTemplate.where(employer: @job.employer).first

          if !@email_template.nil?

            ApplyJobMailer.send_email(@email_template, current_user.email).deliver_later
          end
          message = 'Applied Job Successfully'
        else
          message = 'Something wrong while Applying this Job'
        end
      else
        message = 'You already Applied for this Job'
      end
    else
      message = 'Job is no longer available '
    end

    str =''
    if params[:offset]=='1'
      str = ApplicationHelper.params_constructions_jobs(params)
    end

    respond_to do |format|
      format.html { redirect_to job_path(id: @job.id)+'?'+str, flash: { notice: message } }
      format.json { render :show, status: :created, location: @cart }
    end
  end


  def job_eprofile
    @eprofile = Eprofile.find(params[:id])
    @reviews=Review.where(:to=> @eprofile.employer.user.id)
    @hired_me_employer = ProfileHire.find_by(employer_id: @eprofile.employer.id, jprofile_id: session['jprofile'])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    #   @job = Job.find(params[:id])
    if current_user.role.authority == 'employer'
      @employer = Employer.find_by(user_id: current_user.id)
    elsif current_user.role.authority == 'admin'
      @admin = User.find_by(id: current_user.id)
    else
      redirect_to home_index_path, :alert => 'You are not authenticate user to post a job'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit(
        :title, :description, :education, :experience, :industry_id,
        :keywords, :country,
        :address, :city, :state_list_id,
        :country_list_id, :zip, :salary_type_id,
        :salary,  :relocation, :job_type_id,
        #:certification, :clearance, :references, :category_id, :status, :file,:plain_description
        :certification, :clearance, :references, :status, :file,:plain_description
        #:job_length
    )


  end

  def check_valid_user
    employer = Employer.find_by(user_id: current_user.id)
    check_job = employer.jobs.find_by(id: params[:id])
    redirect_to my_jobs_path, :alert => 'You are not authenticated user for edit this job' if check_job.nil?
  end
end
