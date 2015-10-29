class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def more_comments
    @job = Job.find_by(id: params[:id])
    @comments = Comment.where(:job_id => params[:id] ).order('created_at DESC').paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end


  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

    str =''
    if params[:offset]=='1'
      str = ApplicationHelper.params_constructions_jobs(params)
    end

    respond_to do |format|
      format.html {
        if @comment.save
           redirect_to job_path(id: params[:job_id])+'?'+str, flash: { notice: 'Comment Posted ' }
        else
          redirect_to job_path(id: params[:job_id])+'?'+str, flash: { message: 'Comment Error while Posting ' }
        end
      }

      format.json { render :show, status: :created, location: @cart }
    end

  end


  def update
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.permit(:comment, :job_id, :user_id)
    end
end
