class StateListsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_state_list, only: [:show, :edit, :update, :destroy]

  # GET /state_lists
  # GET /state_lists.json
  def index
      @state_lists = StateList.where(:country_list_id => params[:countryid]).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /state_lists/1
  # GET /state_lists/1.json
  def show
  end

  # GET /state_lists/new
  def new
    @state_list = StateList.new
  end

  # GET /state_lists/1/edit
  def edit
  end

  # POST /state_lists
  # POST /state_lists.json
  def create
    @state_list = StateList.new(state_list_params)

    respond_to do |format|
      if @state_list.save
        format.html { redirect_to state_lists_path, notice: 'State list was successfully created.' }
        format.json { render :show, status: :created, location: @state_list }
      else
        format.html { render :new }
        format.json { render json: @state_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /state_lists/1
  # PATCH/PUT /state_lists/1.json
  def update
    respond_to do |format|
      if @state_list.update(state_list_params)
        format.html { redirect_to state_lists_path, notice: 'State list was successfully updated.' }
        format.json { render :show, status: :ok, location: @state_list }
      else
        format.html { render :edit }
        format.json { render json: @state_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /state_lists/1
  # DELETE /state_lists/1.json
  def destroy
    @state_list.destroy
    respond_to do |format|
      format.html { redirect_to state_lists_url, notice: 'State list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_state_list
    @state_list = StateList.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def state_list_params
    params.require(:state_list).permit(:name,:country_list_id)
  end
end
