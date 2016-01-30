class HomeController < ApplicationController
  skip_filter  :authenticate_user!

  def index

    if !current_user.nil?
     if current_user.role.authority=='jobseeker'
       session['jprofile']=Jobseeker.find_by(user_id:current_user.id).jprofile.id
       session['jobseeker']=Jobseeker.find_by(user_id:current_user.id).id
       #redirect_to jprofiles_path
     elsif current_user.role.authority=='employer'
       session['eprofile']=Employer.find_by(user_id:current_user.id).eprofile.id
       session['employer']=Employer.find_by(user_id:current_user.id).id
       #redirect_to eprofiles_path
     elsif current_user.role.authority=='admin'
       redirect_to admin_index_path

     elsif current_user.role.authority=='staff'

       session['staff_user']= current_user
       session['staff_user_name']= current_user.name

       @user = current_user.employer.user
       session['eprofile']=Employer.find_by(user_id: @user.id).eprofile.id
       session['employer']=Employer.find_by(user_id: @user.id).id

       sign_out current_user
       sign_in @user

     end
    end

    @testimonials = Testimonial.all.limit(4).order('created_at desc')

  @jobs = Job.where(deleted: false, status: true)
  @jprofiles = Jprofile.all
  #@jprofiles = Jprofile.where(deleted: false, active: true)
  @eprofiles = Eprofile.all
  @users=User.all


     @res= Sunspot.search(Job) do

    with(:job_type, params[:job_type].downcase) if params['job_type'].present?
    facet(:job_type)
    with(:companyname, params[:company].downcase) if params['company'].present?
    facet(:companyname)
    with(:industry, params[:industry].downcase) if params['industry'].present?
    facet(:industry)
    with(:state, params[:state].downcase) if params['state'].present?
    facet(:state)

    end

    @res1= Sunspot.search(Jprofile) do
    with(:state, params[:state].downcase) if params['state'].present?
    facet(:state)
    with(:skills, params[:skills].downcase) if params['skills'].present?
    facet(:skills)
    with(:educations, params[:education].downcase) if params['education'].present?
    facet(:educations)

    end
    end
  end
