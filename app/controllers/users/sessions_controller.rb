class Users::SessionsController < Devise::SessionsController
 before_filter :configure_sign_in_params, only: [:new]
 after_filter :after_login, :only => :create
   def after_login
     if current_user.role.authority=='jobseeker'
       session['jprofile']=Jobseeker.find_by(user_id:current_user.id).jprofile.id
       session['jobseeker']=Jobseeker.find_by(user_id:current_user.id).id
     elsif current_user.role.authority=='employer'
       session['eprofile']=Employer.find_by(user_id:current_user.id).eprofile.id
       session['employer']=Employer.find_by(user_id:current_user.id).id
     end
   end
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    # puts '11... '+params[:t].to_s
    # puts '22... '+flash[:t].to_s
    # 
    if params[:t].present?
      flash[:t]=params[:t]
    else
      params[:t]=flash[:t]
    end
    # puts 'params ... '+params.inspect()
    devise_parameter_sanitizer.for(:sign_in) << params[:t]
  end
end
