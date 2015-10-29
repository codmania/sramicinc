class PasswordsController < ApplicationController
	skip_before_filter :authenticate_user!
	def forgot
		@user=User.new
	end

	def email_check
	 if params[:user]
	   session[:email] = params[:user][:email] 
	 end   
	 @user =User.where(:email=> session[:email]).first

	 unless @user
	 	flash.now[:alert] = 'Email is not Registered'
	 	redirect_to url_for(:controller => :passwords, :action => :forgot), :flash => { :error => "Email is not Registered" }
	 end
	end

	def verify_answer
		@user = User.find(params[:user_id])
		session[:user_id] = params[:user_id]
		if @user.security_question_answer == params[:security_question_answer]
			redirect_to url_for(:controller => :passwords, :action => :reset)
		else
			@user.update_column(:failed_attempts,5)
			redirect_to url_for(:controller => :passwords, :action => :email_check), :flash => { :error => "Answer was Incorrect" }
		end
		
	end

	def reset
	  @user=User.new
	end

	def reset_save
		puts params[:user][:password].inspect
		if params[:user][:password].length > 7 && !params[:user][:password].blank? && (params[:user][:password]==params[:user][:password_confirmation])
			@user = User.find(session[:user_id])
			@user.update(user_params)
			puts user_params.inspect
			sign_in @user, :bypass => true
	        redirect_to root_path
	    elsif params[:user][:password].blank? || params[:user][:password].blank? || (params[:user][:password].length < 8)
	       redirect_to url_for(:controller => :passwords, :action => :reset), :flash => { :error => "Password should be min 8 character" }	 	    
	    else
	       redirect_to url_for(:controller => :passwords, :action => :reset), :flash => { :error => "Password doesnot match" }	
	    end    
	end


	def user_params
    # NOTE: Using `strong_parameters` gem
      params.require(:user).permit(:password, :password_confirmation)
    end
end
