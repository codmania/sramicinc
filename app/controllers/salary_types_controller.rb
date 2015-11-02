class SalaryTypesController < ApplicationController
 
  before_action :authenticate_admin_user!
  before_action :set_salary_type, only: [:show, :edit, :update, :destroy]

  # GET /salary_types
  # GET /salary_types.json
  def index
    @salary_types = SalaryType.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /salary_types/1
  # GET /salary_types/1.json
  def show
  end

  # GET /salary_types/new
  def new
    @salary_type = SalaryType.new
  end

  # GET /salary_types/1/edit
  def edit
  end

  # POST /salary_types
  # POST /salary_types.json
  def create
    @salary_type = SalaryType.new(salary_type_params)

    respond_to do |format|
      if @salary_type.save
        format.html { redirect_to salary_types_path, notice: 'Salary Type was successfully created.' }
        format.json { render :show, status: :created, location: @salary_type }
      else
        format.html { render :new }
        format.json { render json: @salary_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salary_types/1
  # PATCH/PUT /salary_types/1.json
  def update
    respond_to do |format|
      if @salary_type.update(salary_type_params)
        format.html { redirect_to salary_types_path, notice: 'Salary Type  was successfully updated.' }
        format.json { render :show, status: :ok, location: @salary_type}
      else
        format.html { render :edit }
        format.json { render json: @salary_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salary_types/1
  # DELETE /salary_types/1.json
  def destroy
    @salary_type.destroy
    respond_to do |format|
      format.html { redirect_to salary_types_url, notice: 'Salary Type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_salary_type
    @salary_type = SalaryType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def salary_type_params
    params.require(:salary_type).permit(:s_type)
  end
end
