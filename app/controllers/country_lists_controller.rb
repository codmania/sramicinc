class CountryListsController < ApplicationController
  #before_action :authenticate_admin_user!
  before_action :set_country_list, only: [:show, :edit, :update, :destroy]

  # GET /country_lists
  # GET /country_lists.json
  def index
    @country_lists = CountryList.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /country_lists/1
  # GET /country_lists/1.json
  def show
  end

  # GET /country_lists/new
  def new
    @country_list = CountryList.new
  end

  # GET /country_lists/1/edit
  def edit
  end

  # POST /country_lists
  # POST /country_lists.json
  def create
    @country_list = CountryList.new(country_list_params)

    respond_to do |format|
      if @country_list.save
        format.html { redirect_to country_lists_path, notice: 'Country list was successfully created.' }
        format.json { render :show, status: :created, location: @country_list }
      else
        format.html { render :new }
        format.json { render json: @country_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /country_lists/1
  # PATCH/PUT /country_lists/1.json
  def update
    respond_to do |format|
      if @country_list.update(country_list_params)
        format.html { redirect_to country_lists_path, notice: 'Country list was successfully updated.' }
        format.json { render :show, status: :ok, location: @country_list }
      else
        format.html { render :edit }
        format.json { render json: @country_list.errors, status: :unprocessable_entity }
      end
    end
  end


  def country_list_update
    @states = StateList.where(:country_list_id => params[:countryid])
    render :partial => 'country_list_update'
  end

  # DELETE /country_lists/1
  # DELETE /country_lists/1.json
  def destroy
    @country_list.destroy
    respond_to do |format|
      format.html { redirect_to country_lists_url, notice: 'Country list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_country_list
    @country_list = CountryList.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def country_list_params
    params.require(:country_list).permit(:name)
  end
end
