
  class Users::PasswordsController < Devise::PasswordsController
    include SimpleCaptcha::ControllerHelpers
    before_action :check_user_role, only: [:create]

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
   def edit
     super
   end

  # PUT /resource/password
 
   def update
     if simple_captcha_valid?
        super()
      else
        clean_up_passwords resource
        set_minimum_password_length
        flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
        redirect_to edit_user_password_path(reset_password_token:params['user']['reset_password_token'])
      end
    end

  # protected

  # def after_resetting_password_path_for(resource)
  #   # super(resource)
  #   if resource.role.authority=='employer'
  #     new_user_session_path(t:'employer')
  #   else
  #     new_user_session_path(t:'candidate')
  #   end
  # end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
  
    if resource.role.authority=='employer'
      new_user_session_path(t:'employer')
    else
      new_user_session_path(t:'candidate')
    end
  end


  def after_resetting_password_path_for(resource)

    sign_out(resource)
    if resource.role.authority=='employer'
      new_user_session_path(t:'employer')
    else
      new_user_session_path(t:'candidate')
    end

  end

  # Restricted for staff user
  def check_user_role

    email = params[:user][:email]
    @user = User.where(email: email).first

    if !@user.nil? && @user.role.authority == 'staff'
      redirect_to new_password_path(@user), flash: { message: 'You can not reset the password, because you are staff user of an employerZ' }
      return
    end

  end

end