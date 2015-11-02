class CityListsController < ApplicationController
  before_action :set_city_list, only: [:show, :edit, :update, :destroy]

  # GET /city_lists
  # GET /city_lists.json
  def index
    @city_lists = CityList.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /city_lists/1
  # GET /city_lists/1.json
  def show
  end

  # GET /city_lists/new
  def new
    @city_list = CityList.new
  end

  # GET /city_lists/1/edit
  def edit
  end

  # POST /city_lists
  # POST /city_lists.json
  def create
    @city_list = CityList.new(city_list_params)

    respond_to do |format|
      if @city_list.save
        format.html { redirect_to city_lists_path, notice: 'City list was successfully created.' }
        format.json { render :show, status: :created, location: @city_list }
      else
        format.html { render :new }
        format.json { render json: @city_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /city_lists/1
  # PATCH/PUT /city_lists/1.json
  def update
    respond_to do |format|
      if @city_list.update(city_list_params)
        format.html { redirect_to city_lists_path, notice: 'City list was successfully updated.' }
        format.json { render :show, status: :ok, location: @city_list }
      else
        format.html { render :edit }
        format.json { render json: @city_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /city_lists/1
  # DELETE /city_lists/1.json
  def destroy
    @city_list.destroy
    respond_to do |format|
      format.html { redirect_to city_lists_url, notice: 'City list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city_list
      @city_list = CityList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_list_params
      params.require(:city_list).permit(:name)
    end
end
