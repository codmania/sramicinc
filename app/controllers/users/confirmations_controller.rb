class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   self.resource = resource_class.send_confirmation_instructions(resource_params)
  #   yield resource if block_given?
  #
  #   if successfully_sent?(resource)
  #     puts "111111111"
  #     respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
  #   else
  #     puts "22222222222222"
  #     respond_with(resource)
  #   end
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  protected
  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   # super(resource_name)
  #   puts ';gggg '+(resource.has_role? :employer).to_s
  #   if resource.has_role? :employer
  #       new_item_path(t:employer)
  #     else
  #       new_item_path(t:jobseeker)
  #     end
  # end
  #
  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    #puts ';gggg '+(resource.role.authority).to_s
    if resource.role.authority=='employer'
        new_user_session_path(t:'employer')
    else
        new_user_session_path(t:'candidate')
    end
  end
end
