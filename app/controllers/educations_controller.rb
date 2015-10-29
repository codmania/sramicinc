class EducationsController < ApplicationController
  before_action :authenticate_jobseeker_user!
  load_and_authorize_resource except: [:create]
  before_action :set_jprofile, only: [:update, :create]
  before_action :set_education, only: [:show, :edit, :update, :destroy]
  before_action :set_dependents, only: [:new, :edit, :update]

  # GET /educations
  # GET /educations.json
  def index

    @educations = Education.where(jprofile_id: session['jobseeker'])
    @certifications = Certification.where(jprofile_id: session['jobseeker'])
    @journals = Journal.where(jprofile_id: session['jobseeker'])




    # if current_user.role.authority=='admin'
    #     @educations = Education.all
    # end
    # if current_user.role.authority=='jobseeker'
    #     redirect_to @jprofile
    # end

  end

  # GET /educations/1
  # GET /educations/1.json
  def show
  end

  # GET /educations/new
  def new
    @education = Education.new
  end

  # GET /educations/1/edit
  def edit
  end

  # POST /educations
  # POST /educations.json
  def create
    @education = Education.new(education_params)
    @education.jprofile_id = @jprofile.id

    respond_to do |format|
      if @education.save
        format.html { redirect_to educations_url, notice: 'Education was successfully created.' }
        format.json { render :show, status: :created, location: @education }
      else
        format.html { render :new }
        format.json { render json: @education.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /educations/1
  # PATCH/PUT /educations/1.json
  def update
    respond_to do |format|
      if @education.update(education_params)
        format.html { redirect_to educations_url, notice: 'Education was successfully updated.' }
        format.json { render :show, status: :ok, location: @education }
      else
        format.html { render :edit }
        format.json { render json: @education.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.json
  def destroy
    @education.destroy
    respond_to do |format|
      format.html { redirect_to educations_url, notice: 'Education was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_education
    @education = Education.find(params[:id])
  end

  def set_jprofile
    if current_user.role.authority=='jobseeker'
        @jprofile = Jobseeker.find_by(user_id:current_user.id).jprofile
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def education_params
    #params.require(:education).permit(:is_highest_qualification, :title,:year_attained,:qualification_id,:university_id, :discipline_id, :grade_id, :jprofile_id)
    params.require(:education).permit(:degree,:field,:institution,:location,:completion)
  end

  def set_dependents
    @qualifications = Qualification.all
    @universities = University.all
    @grades = Grade.all
    @disciplines = Discipline.all
  end
end
