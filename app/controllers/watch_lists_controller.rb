class WatchListsController < ApplicationController
  before_action :authenticate_jobseeker_user!
  before_action :set_watch_list, only: [:show, :edit, :update, :destroy]

  # GET /watch_lists
  # GET /watch_lists.json
  def index
    @watch_lists = WatchList.where(jobseeker_id: session['jobseeker']).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /watch_lists/1
  # GET /watch_lists/1.json
  def show
  end

  # GET /watch_lists/new
  def new
    @watch_list = WatchList.new
  end

  # GET /watch_lists/1/edit
  def edit
  end

  # POST /watch_lists
  # POST /watch_lists.json
  def create
    @watch_list = WatchList.new(watch_list_params)

    respond_to do |format|
      if @watch_list.save
        format.html { redirect_to @watch_list, notice: 'Watch list was successfully created.' }
        format.json { render :show, status: :created, location: @watch_list }
      else
        format.html { render :new }
        format.json { render json: @watch_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /watch_lists/1
  # PATCH/PUT /watch_lists/1.json
  def update
    respond_to do |format|
      if @watch_list.update(watch_list_params)
        format.html { redirect_to @watch_list, notice: 'Watch list was successfully updated.' }
        format.json { render :show, status: :ok, location: @watch_list }
      else
        format.html { render :edit }
        format.json { render json: @watch_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /watch_lists/1
  # DELETE /watch_lists/1.json
  def destroy
    @watch_list.destroy
    respond_to do |format|
      format.html { redirect_to watch_lists_url, notice: 'Watch list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watch_list
      @watch_list = WatchList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def watch_list_params
      params.require(:watch_list).permit(:job_id, :jobseeker_id)
    end
end
