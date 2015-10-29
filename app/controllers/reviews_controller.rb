class ReviewsController < ApplicationController
  def index

     if params[:by] == 'me'
       @reviews=Review.where(:from=>current_user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
     else
       @reviews=Review.where(:to=>current_user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
     end
      @reviewresp = ReviewResponse.where(review_id: @reviews)
     # @user = User.all
      # @jobseeker_messages=Jcontact.where(job_application_id: @jobapplication.pluck(:id)).paginate(:page => params[:page], :per_page => 4)
      if current_user.role.authority == 'jobseeker'
        @review_to = Jprofile.find_by(id: session['jobseeker']).name
      elsif current_user.role.authority == 'employer'
        @review_to = Eprofile.find_by(id: session['eprofile']).company_name
      end
  end

  def new
  	@review=Review.new
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      Notification.create(user_id: params[:to], url: "#{request.base_url}/reviews", n_type: 'Review')
      render :text => 'review created', content_type: 'text/plain'
    else
      render :text=> 'Error', content_type: 'text/plain'
    end
  end

  def edit
  end

  def delete
  end

  def show
  	@reviews=Review.where(:employer_id=>session['employer'])
  end

  def review_respond
    @review_response = ReviewResponse.new(from: params[:from], response: params[:response], review_id: params[:review_id])

    if @review_response.save
      render :text => 'Responded for this Review', content_type: 'text/plain'
    else
      render :text => 'Error', content_type: 'text/plain'
    end
  end

  private
  def review_params
  	params.permit(:pros,:cons,:recommendations,:to,:from,:score)
  end
end
