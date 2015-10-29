class FaqCategoriesController < ApplicationController
  before_action :set_faq_category, only:  [:edit, :update, :destroy]
  def index
     @faqcategories = FaqCategory.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  def create
     @faqcategory= FaqCategory.new(faq_category_params)

    respond_to do |format|
      if @faqcategory.save
        format.html { redirect_to faq_categories_url, notice: 'FAQ Category was successfully created.' }
        format.json { render :show, status: :created, location: @faqcategory}
      else
        format.html { render :new }
        format.json { render json: @faqcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end
  def destroy
    @faqcategory.destroy
    respond_to do |format|
      format.html { redirect_to faq_categories_url, notice: 'FAQ Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete
  end

  def update
     @faqcategory=FaqCategory.find params[:id]
    respond_to do |format|
      if @faqcategory.update(faq_category_params)
        format.html { redirect_to faq_categories_url, notice: 'FAQ Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @faqcategory }
      else
        format.html { render :edit }
        format.json { render json: @faqcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @faqcategory=FaqCategory.new
  end
  private
  def set_faq_category
    @faqcategory = FaqCategory.find(params[:id])
  end

  def faq_category_params
    params.require(:faq_category).permit(:name)
  end
end
