class Users::RegistrationsController < Devise::RegistrationsController
before_filter :configure_sign_up_params, only: [:create]
before_filter :configure_account_update_params, only: [:update]
include SimpleCaptcha::ControllerHelpers
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create

    if simple_captcha_valid?
      puts params[:user][:role_id].inspect
      build_resource(sign_up_params)
      resource.role_id = params[:user][:role_id]
      resource.save
      yield resource if block_given?


      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          puts"1"
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        if params[:user][:role_id]=="3"
          resource.errors.full_messages.each {|x| flash[x] = x}
          redirect_to new_user_registration_path
        else
          resource.errors.full_messages.each {|x| flash[x] = x}
          redirect_to employer_registration_path(resource)
        end
      end

    else
      clean_up_passwords resource
      set_minimum_password_length
      flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
      if params[:user][:role_id]=="3"
        redirect_to new_user_registration_path
      else
        redirect_to employer_registration_path(resource)
      end

    end




    # puts params[:user][:role_id].inspect
    # build_resource(sign_up_params)
    # resource.role_id = params[:user][:role_id]
    # resource.save
    # yield resource if block_given?
    # if resource.persisted?
    #   if resource.active_for_authentication?
    #     set_flash_message :notice, :signed_up if is_flashing_format?
    #     sign_up(resource_name, resource)
    #     respond_with resource, location: after_sign_up_path_for(resource)
    #   else
    #     puts"1"
    #     set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
    #     expire_data_after_sign_in!
    #     respond_with resource, location: after_inactive_sign_up_path_for(resource)
    #   end
    # else
    #   clean_up_passwords resource
    #   set_minimum_password_length
    #   if params[:user][:role_id]=="3"
    #     resource.errors.full_messages.each {|x| flash[x] = x}
    #     redirect_to new_user_registration_path
    #   else
    #     resource.errors.full_messages.each {|x| flash[x] = x}
    #     redirect_to employer_registration_path(resource)
    #   end
    # end
  end
  def employer_registration
    build_resource({})
    # puts resource.inspect
    # r=resource.employers.build
    # @k=r.eprofile.build
    set_minimum_password_length
    yield resource if block_given?
    respond_with self.resource
  end
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :role_id,:captcha, :captcha_key,:security_question_id,:security_question_answer,:confirmation_token,:confirmed_at,:confirmation_sent_at,:unconfirmed_email) }
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :attribute
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    # super(resource)
    if resource.role.authority=='employer'
      new_user_session_path(t:'employer')
    else
      new_user_session_path(t:'candidate')
    end
  end
end
