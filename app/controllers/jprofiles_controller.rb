class JprofilesController < ApplicationController
  before_action :set_jprofile, only: [:index, :show, :edit, :update, :destroy]

  # GET /jprofiles
  # GET /jprofiles.json
  def home

  end

  def index

    if current_user.role.authority == 'employer' || current_user.role.authority=='admin'
      respond_to do |format|
        format.html { redirect_to home_index_url, alert: 'You are not authendicated person to enter this.' }
        format.json { head :no_content }
      end
    end
=begin
    if current_user.role.authority=='admin'
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'You are not authendicated person to enter this.' }
        format.json { head :no_content }
      end
    end
=end
    if current_user.role.authority=='jobseeker'
      redirect_to @jprofile
    end


  end

  # GET /jprofiles/1
  # GET /jprofiles/1.json
  def show
    #@jprofile = Jprofile.find(session['jprofile'])
    @jprofile = Jprofile.find(params[:id])
    @education = Education.find_by(jprofile_id: @jprofile.id)
    @job_history = JobHistory.find_by(jprofile_id: @jprofile.id)
  end

  # GET /jprofiles/new
  def new
    if current_user.role.authority == 'employer'
      respond_to do |format|
        format.html { redirect_to home_index_url, alert: 'You are not authendicated person to enter this.' }
        format.json { head :no_content }
      end
    end
    @jprofile = Jprofile.new
    @jprofile.jobseeker_id = Jobseeker.where(user_id: current_user).last.id
  end

  # GET /jprofiles/1/edit
  def edit
  end

  # POST /jprofiles
  # POST /jprofiles.json
  def create
    @jprofile = Jprofile.new(jprofile_params)

    respond_to do |format|
      if @jprofile.save
        format.html { redirect_to @jprofile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @jprofile }
      else
        format.html { render :new }
        format.json { render json: @jprofile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jprofiles/1
  # PATCH/PUT /jprofiles/1.json
  def update
    respond_to do |format|
      if @jprofile.update(jprofile_params)
        format.html { redirect_to @jprofile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @jprofile }
      else
        format.html { render :edit }
        format.json { render json: @jprofile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jprofiles/1
  # DELETE /jprofiles/1.json
  def destroy
    @jprofile.destroy
    respond_to do |format|
      format.html { redirect_to jprofiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def download_resume

    @jprofile = Jprofile.find(params[:id])
    send_file "#{@jprofile.resume.path}",
              :type => "#{@jprofile.resume_content_type}"
  end

  # private
  # Use callbacks to share common setup or constraints between actions.
  def set_jprofile
    if current_user.role.authority=='admin'
      if params[:id]
        @jprofile =Jprofile.find(params[:id])
      end
    else
      @jprofile = Jobseeker.find_by(user_id: current_user.id).try(:jprofile)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def jprofile_params

    params.require(:jprofile).permit(:name, :title, :logo, :resume, :phone, :city, :state_list_id, :country_list_id, :zip, :summary, :date_of_birth,
                                     :marital_status, :resume_headline, :salary_type_id, :salary, :address1, :address2)


  end
end
