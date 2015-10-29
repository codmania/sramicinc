class JournalsController < ApplicationController
  before_action :authenticate_jobseeker_user!
  load_and_authorize_resource except: [:create]
  before_action :set_journal, only: [:show, :edit, :update, :destroy]
  before_action :set_jprofile, only: [:update, :create]

  # GET /journals
  # GET /journals.json
  def index
    @journals = Journal.where(jprofile_id: session['jobseeker'])
  end

  # GET /journals/1
  # GET /journals/1.json
  def show
  end

  # GET /journals/new
  def new
    @journal = Journal.new
  end

  # GET /journals/1/edit
  def edit
  end

  # POST /journals
  # POST /journals.json
  def create
    @journal = Journal.new(journal_params)
    @journal.jprofile_id = @jprofile.id

    respond_to do |format|
      if @journal.save
        format.html { redirect_to educations_url, notice: 'Journal was successfully created.' }
        format.json { render :show, status: :created, location: @journal }
      else
        format.html { render :new }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /journals/1
  # PATCH/PUT /journals/1.json
  def update
    respond_to do |format|
      if @journal.update(journal_params)
        format.html { redirect_to educations_url, notice: 'Journal was successfully updated.' }
        format.json { render :show, status: :ok, location: @journal }
      else
        format.html { render :edit }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /journals/1
  # DELETE /journals/1.json
  def destroy
    @journal.destroy
    respond_to do |format|
      format.html { redirect_to educations_url, notice: 'Journal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal
      @journal = Journal.find(params[:id])
    end

    def set_jprofile
      if current_user.role.authority=='jobseeker'
        @jprofile = Jobseeker.find_by(user_id:current_user.id).jprofile
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def journal_params
      params.require(:journal).permit(:name, :date, :reference)
    end
end
