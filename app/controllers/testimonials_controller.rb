class TestimonialsController < ApplicationController
before_action :authenticate_admin_user!
before_action :set_testimonial, only: [:show, :edit, :update, :destroy]
  def index
    @testimonials=Testimonial.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  def show

  end

  def new
    @testimonial=Testimonial.new
  end

  def edit
  end

  def create
    @testimonial = Testimonial.new(testimonial_params)
    @testimonial.user_id =current_user.id

    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to testimonials_url, notice: 'testimonial was successfully created.' }
        format.json { render :show, status: :created, location: @testimonial }
      else
        format.html { render :new }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @testimonial.update(testimonial_params)
        format.html { redirect_to testimonials_url, notice: 'testimonial was successfully updated.' }
        format.json { render :show, status: :ok, location: @testimonial }
      else
        format.html { render :edit }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @testimonial.destroy
    respond_to do |format|
      format.html { redirect_to testimonials_url, notice: 'testimonial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def testimonial_params
    #params.require(:testimonial).permit(:year_of_experience, :last_used_year, :testimonial_set_id, :jprofile_id)
    #params.require(:testimonial).permit(:name, :email, :company, :description, :logo)
    params.require(:testimonial).permit(:name, :company, :description, :logo)
  end

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

end
