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

  @jobs = Job.all
  @jprofiles = Jprofile.all
  @eprofiles = Eprofile.all
  @users=User.all


     @res= Sunspot.search(Job) do

    with(:categoryname, params[:category].downcase) if params['category'].present?
    facet(:categoryname)
    with(:companyname, params[:company].downcase) if params['company'].present?
    facet(:companyname)
    with(:industry, params[:industry].downcase) if params['industry'].present?
    facet(:industry)
    with(:city, params[:city].downcase) if params['city'].present?
    facet(:city)

    end

    @res1= Sunspot.search(Jprofile) do
    facet(:city)
    with(:skills, params[:skills].downcase) if params['skills'].present?
    facet(:skills)
    with(:educations, params[:education].downcase) if params['education'].present?
    facet(:educations)
    
    end
    end
  end


