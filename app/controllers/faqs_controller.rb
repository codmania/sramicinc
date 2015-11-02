class FaqsController < ApplicationController
#before_action :authenticate_admin_user!
skip_filter  :authenticate_user!, only: [:index]
  before_action :authenticate_admin_user!, only: [:destroy, :new, :edit, :create]
 before_action :set_faq, only: [:edit, :update, :destroy]
  def index
      @faqs1= Faq.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT).order('faq_category_id asc')
      @faqs= Faq.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT).order('faq_category_id asc').group_by(&:faq_category_id)
      @fc = FaqCategory.where(id: Faq.pluck(:faq_category_id))
  end

  def create
    @faq = Faq.new(faq_params)
     respond_to do |format|
        if @faq.save
          format.html { redirect_to faqs_path, notice: 'FAQ was successfully created.' }
          format.json { render :show, status: :created, location: @faq }
        else
          format.html { render :new }
          format.json { render json: @faq.errors, status: :unprocessable_entity }
        end
      end
  end

  def edit
  end

  def destroy
    @faq.destroy
    respond_to do |format|
      format.html { redirect_to faqs_url, notice: 'FAQ was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
     @faq=Faq.find(params[:id])
    respond_to do |format|
      if @faq.update(faq_params)
        format.html { redirect_to  faqs_path , notice: 'FAQ was successfully updated.' }
        format.json { render :show, status: :ok, location: @faq }
      else
        format.html { render :edit }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @faq = Faq.new
  end

  private
  def set_faq
    @faq = Faq.find(params[:id])

  end
  def faq_params
    params.require(:faq).permit(:faq_category_id,:question,:answer)
  end
end
