class ApplicationController < ActionController::Base
  # reset captcha code after each request for security
  after_filter :reset_last_captcha_code!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :setUserType
  before_action :authenticate_user!

  skip_before_action :verify_authenticity_token

  def setUserType
    puts 'setUserype '+params.inspect
    if params['t']=='candidate'
      flash['t']='candidate'
    elsif params['t']=='employer'
      flash['t']='employer'
    end
  end

  #   before_action :authenticate_admin_user!
  def authenticate_admin_user!

    if !current_user.nil?
      if current_user.role.authority == 'admin'
          return true
      end
    end
      redirect_to root_path,  alert: 'You are not permitted to access this resource'
  end


  #   before_action :authenticate_jobseeker_user!
  def authenticate_jobseeker_user!

    if !current_user.nil?
      if current_user.role.authority == 'jobseeker'
        return true
      end
    end
    redirect_to root_path,  alert: 'You are not permitted to access this resource'
  end

  #   before_action :authenticate_employer_user!
  def authenticate_employer_user!

    if !current_user.nil?
      if current_user.role.authority == 'employer'
        return true
      end
    end
    redirect_to root_path,  alert: 'You are not permitted to access this resource'
  end


  #   before_action :check_staff_user!
  def check_staff_user!

    if !current_user.nil?
      if !session['staff_user'].nil?
        redirect_to root_path,  alert: 'You are not permitted to access this resource'
      end
      return true
    end

  end

  def activate_payment_module
    if !PaymentModule.first.active?
          redirect_to root_path,  alert: 'Payment Module not activated yet'
    end
    return true
  end

  def user_subscription_validate_job_post!
      flag =  false
       if current_user.subscription.plan.job_post.nil?
           flag = false
       elsif current_user.subscription.plan.job_post == -1
         flag =  true
       else
           jobs = Job.where(employer: session['employer'], status: true)
           if !jobs.nil? && !(current_user.subscription.plan.job_post >= jobs.count)
             flag =  false
           else
             flag =  true
           end
       end

       if !flag
         redirect_to root_path,  alert: 'Your subscribed plan does not support'
       end
       return flag
  end

  def user_subscription_validate_staff_user_creation!
    flag =  false
    if current_user.subscription.plan.user_account.nil?
      flag = false
    elsif current_user.subscription.plan.user_account == -1
      flag =  true
    else
      staff_users = User.where(employer_id: session['employer'])
      if !staff_users.nil? && !(current_user.subscription.plan.user_account >= staff_users.count)
        flag =  false
      else
        flag =  true
      end
    end

    if !flag
      redirect_to root_path,  alert: 'Your subscribed plan does not support'
    end
    return flag
  end


  def payment_module_activated
    PaymentModule.first.active?
  end

  # CRON JOB for Plan
  # def plan_checker
  #   Subscription.all.each { |subscription|
  #
  #     if !subscription.end_date.nil? && subscription.end_date <= Time.now
  #
  #   }
  # end


  # Catch all CanCan errors and alert the user of the exception
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_path, alert: 'You are not permitted to access this resource'
  end


end
