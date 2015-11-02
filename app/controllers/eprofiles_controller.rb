class EprofilesController < ApplicationController
  # layout 'employer'
  before_action :set_eprofile, only: [:index,:show, :edit, :update, :destroy]

  def home
  end
  def index
    if current_user.role.authority=='admin'
        @eprofiles = Eprofile.all
    end
    if current_user.role.authority=='employer'
      # if @eprofile.nil?
      #    emp=Employer.find_by(user_id:current_user.id)
      #    @eprofile=Eprofile.create(company_name:emp.name,employer_id:emp.id )
      # end
      redirect_to @eprofile
    end
  end

  def show
    if current_user.role.authority == 'admin'
      @eprofile = Eprofile.find(params[:id])
      @jobs=Job.where(:employer_id=>@eprofile.employer_id)
    else

      puts params[:countryid]
      @eprofile = Eprofile.find(session['eprofile'])
      @jobs=Job.where(:employer_id=>current_user.id)
    end


  end



  def new
  	@eprofile = Eprofile.new
    @eprofile.employer_id = Employer.where(user_id: current_user).last.id
  end

  def create
  	@eprofile = Eprofile.new(eprofile_params)

    respond_to do |format|
      if @eprofile.save
        format.html { redirect_to @eprofile, notice: 'Eprofile was successfully created.' }
        format.json { render :show, status: :created, location: @eprofile }
      else
        format.html { render :new }
        format.json { render json: @eprofile.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  	respond_to do |format|
      if @eprofile.update(eprofile_params)
        format.html { redirect_to @eprofile, notice: 'Eprofile was successfully updated.' }
        format.json { render :show, status: :ok, location: @eprofile }
      else
        format.html { render :edit }
        format.json { render json: @eprofile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @eprofile.destroy
    respond_to do |format|
      format.html { redirect_to eprofiles_url, notice: 'Employer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
	# Use callbacks to share common setup or constraints between actions.
	def set_eprofile
    if current_user.role.authority=='admin'
        @eprofile =Eprofile.find(params[:id])
    else
        @eprofile = Employer.find_by(user_id:current_user.id).try(:eprofile)
    end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def eprofile_params
	  params.require(:eprofile).permit(:name,:company_name,:company_type,:industry_id,:address1,:address2,:city,:state_list_id,:country_list_id,:zip,:phone,:website,:overview,:products,:services,:employer_id, :logo, :fb_url, :twitter_url, :gplus_url, :linkedin_url,:fax)
	end
end
