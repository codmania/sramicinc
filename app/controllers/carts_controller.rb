class CartsController < ApplicationController
  before_action :authenticate_jobseeker_user!
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    @jobCarts = Cart.where(jobseeker_id: session['jobseeker']).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def applyJob

    @cart = Cart.find(params[:id])

    if !@cart.nil?
          @job_application = JobApplication.find_by(job_id: @cart.job_id, jobseeker_id: @cart.jobseeker_id)

          if @job_application.nil?
            @job_application = JobApplication.new(job_id: @cart.job_id, jobseeker_id: @cart.jobseeker_id)
              if @job_application.save && @cart.destroy
                message = 'Applied Job Successfully'
              else
                message = 'Something wrong while Applying this Job'
              end
          else
              message = 'You already Applied for this Job'
          end
    else
       message = 'Job is not available in you cart'
    end



    respond_to do |format|
        format.html { redirect_to carts_url, :flash => {:notice => message}}
        format.json { render :show, status: :created, location: @cart }
    end
  end


  def apply_all_jobs

    @cartJobs = Cart.where(jobseeker_id: session['jobseeker'])

    if !@cartJobs.empty?

      @cartJobs.each { |cart|
        @job_application = JobApplication.create(job_id: cart.job_id, jobseeker_id: cart.jobseeker_id)
        cart.destroy
      }
      message = 'Applied All Job Successfully'
    else
      message = "Job's are not available in you cart"
    end

    respond_to do |format|
      format.html { redirect_to carts_url, :flash => {:notice => message}}
      format.json { render :show, status: :created, location: @cart }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cart
    @cart = Cart.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cart_params
    params.require(:cart).permit(:job_id, :jobseeker_id)
  end
end
