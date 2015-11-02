class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end


  def all
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # puts '*****************'+request.env["omniauth.auth"].provider.to_s
    # puts "******************request.env['omniauth.params']   "+request.env['omniauth.params'].to_s

      @user = User.from_omniauth(request.env["omniauth.auth"], request.env['omniauth.params'])

      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
#          set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        redirect_to new_user_registration_url
      end


=begin
    if request.env["omniauth.auth"].provider != 'twitter' && request.env["omniauth.auth"].provider != 'linked_in'
        @user = User.from_omniauth(request.env["omniauth.auth"])

        if @user.persisted?
          sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
#          set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
          redirect_to new_user_registration_url
        end
    else
        # session[:provider] = request.env["omniauth.auth"].provider
        # session[:uid] = request.env["omniauth.auth"].uid
        session[:omniauth] =  request.env["omniauth.auth"].except('extra')
        # puts '============================'
        # puts session[:omniauth]
        # puts '============================'
        redirect_to(:controller => '/socialemail', :action => 'email')

    end
=end

  end



  alias_method :facebook, :all
#	alias_method :twitter, :all
	# alias_method :linkedin, :all
	# alias_method :github, :all
	# alias_method :passthru, :all
	 alias_method :google_oauth2, :all


end
