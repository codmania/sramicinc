class EnquiryCategoriesController < ApplicationController
 
 before_action :authenticate_admin_user!
 before_action :set_enquiry_category, only: [:show, :edit, :update, :destroy]

  # GET /enquiry_category
  # GET /enquiry_categories.json
  def index
    @enquiry_categories = EnquiryCategory.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /enquiry_categories/1
  # GET /enquiry_category/1.json
  def show
  end

  # GET /enquiry_categories/new
  def new
    @enquiry_category= EnquiryCategory.new
  end

  # GET /enquiry_categories/1/edit
  def edit
  end

  # POST /enquiry_categories
  # POST /enquiry_categories.json
  def create
    @enquiry_category= EnquiryCategory.new(enquiry_category_params)

    respond_to do |format|
      if @enquiry_category.save
        format.html { redirect_to enquiry_categories_url, notice: 'Enquiry Category was successfully created.' }
        format.json { render :show, status: :created, location: @enquiry_category}
      else
        format.html { render :new }
        format.json { render json: @enquiry_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enquiry_categories/1
  # PATCH/PUT /enquiry_categories/1.json
  def update
    respond_to do |format|
      if @enquiry_category.update(enquiry_category_params)
        format.html { redirect_to enquiry_categories_url, notice: 'Enquire Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @enquiry_category }
      else
        format.html { render :edit }
        format.json { render json: @enquiry_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enquiry_categories/1
  # DELETE /enquiry_categories/1.json
  def destroy
    @enquiry_category.destroy
    respond_to do |format|
      format.html { redirect_to enquiry_categories_url, notice: 'Enquire Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enquiry_category
      @enquiry_category = EnquiryCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enquiry_category_params
      params.require(:enquiry_category).permit(:name)
    end
end


