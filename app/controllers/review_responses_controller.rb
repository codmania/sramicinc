class ReviewResponsesController < ApplicationController
  def index
     @review=Review.find(params[:id])
      @reviewresp = ReviewResponse.where(review_id: @review)
      if current_user.role.authority == 'jobseeker'
        @review_to = Jprofile.find_by(id: session['jobseeker']).name
      elsif current_user.role.authority == 'employer'
        @review_to = Eprofile.find_by(id: session['eprofile']).company_name
      end
  end

  def new
  end

  def create
     @reviewresp = ReviewResponse.new(reviewresp_params)

    respond_to do |format|
      format.html {
        if @reviewresp.save
          redirect_to review_responses_path(:id => params[:review_id]), :flash => {:notice => 'Response Posted '}
        else
          redirect_to review_responses_path(:id => params[:review_id]), :flash => {:notice => 'Response Error while Posting '}
        end
      }

      format.json { render :show, status: :created, location: @reviewresp }
    end

  end

  def edit
  end

  def show
  end

  def delete
  end
  private
  def reviewresp_params
    params.permit(:review_id,:from,:response)
  end
end
