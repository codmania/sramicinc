class SocialemailController < ApplicationController

  skip_before_action :authenticate_user!


  def email
    if session[:omniauth]['provider']  && session[:omniauth]['uid']

      @user = User.from_omniauth_checker(session[:omniauth])

      if !@user.nil?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      elsif params[:email]
          @user = User.save_omniauth(session[:omniauth]['provider'], session[:omniauth]['uid'], params[:email])
          if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
          else
            redirect_to new_user_registration_url
          end
      end
    else
      redirect_to new_user_registration_url
    end
  end



end
