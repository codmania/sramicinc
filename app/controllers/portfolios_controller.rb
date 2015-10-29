class PortfoliosController < ApplicationController
  before_action :authenticate_jobseeker_user!
  load_and_authorize_resource except: [:create]
  before_action :set_portfolio, only: [:update, :destroy, :show, :edit]
  before_action :set_jprofile, only: [:update, :create]
  #before_action :set_dependents, only: [:new, :edit, :update]

  # GET /portfolios
  # GET /portfolios.json
  def index
    @portfolios = Portfolio.where(jprofile_id: session['jobseeker'])
  end

  # GET /portfolios/1
  # GET /portfolios/1.json
  def show
  end

  # GET /portfolios/new
  def new
    @portfolio = Portfolio.new
  end

  # GET /portfolios/1/edit
  def edit
  end

  # POST /portfolios
  # POST /portfolios.json
  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.jprofile_id = @jprofile.id

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully created.' }
        format.json { render :show, status: :created, location: @portfolio }
      else
        format.html { render :new }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portfolios/1
  # PATCH/PUT /portfolios/1.json
  def update
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully updated.' }
        format.json { render :show, status: :ok, location: @portfolio }
      else
        format.html { render :edit }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    @portfolio.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end

    def set_jprofile
      if current_user.role.authority=='jobseeker'
        @jprofile = Jobseeker.find_by(user_id:current_user.id).jprofile
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def portfolio_params
      params.require(:portfolio).permit(:name, :url, :logo)
    end
end
