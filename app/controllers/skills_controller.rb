class SkillsController < ApplicationController
  before_action :authenticate_jobseeker_user!
  #load_and_authorize_resource
  load_and_authorize_resource except: [:create]
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  before_action :set_jprofile, only: [:update, :create]
  before_action :set_dependents, only: [:new, :edit, :update]

  # GET /skills
  # GET /skills.json
  def index

    @skills = Skill.where(jprofile_id: session['jobseeker']).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
    # if current_user.role.authority=='admin'
    #   @skills = Skill.all
    # end
    # if current_user.role.authority=='jobseeker'
    #   redirect_to @jprofile
    # end
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
  end

  # GET /skills/new
  def new
    @skill = Skill.new
  end

  # GET /skills/1/edit
  def edit
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = Skill.new(skill_params)
    @skill.jprofile_id = @jprofile.id

    respond_to do |format|
      if @skill.save
        format.html { redirect_to skills_url, notice: 'Skill was successfully created.' }
        format.json { render :show, status: :created, location: @skill }
      else
        format.html { render :new }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skills/1
  # PATCH/PUT /skills/1.json
  def update
    respond_to do |format|
      if @skill.update(skill_params)
        format.html { redirect_to skills_url, notice: 'Skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @skill }
      else
        format.html { render :edit }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    @skill.destroy
    respond_to do |format|
      format.html { redirect_to skills_url, notice: 'Skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      #params.require(:skill).permit(:year_of_experience, :last_used_year, :skill_set_id, :jprofile_id)
      params.require(:skill).permit(:name, :year_of_experience)
    end

    def set_jprofile
      if current_user.role.authority=='jobseeker'
        @jprofile = Jobseeker.find_by(user_id:current_user.id).jprofile
      end
    end

    def set_dependents
      @skill_sets = SkillSet.all
    end
end
