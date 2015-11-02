class ProfileHiresController < ApplicationController
   before_action :set_profile_hire, only: [:show, :edit, :update, :destroy]

  
  def index
    @ProfileHires=ProfileHire.where(employer_id: session['employer']).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

 
  def show
  end

  
  def new
    @ProfileHires = ProfileHire.new
  end

  
  def edit
  end

  
  def create
    @ProfileHire = ProfileHire.new(ProfileHire_params)

    respond_to do |format|
      if @ProfileHire.save
        format.html { redirect_to @ProfileHire, notice: 'ProfileHire was successfully created.' }
        format.json { render :show, status: :created, location: @ProfileHire }
      else
        format.html { render :new }
        format.json { render json: @ProfileHire.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ProfileHire.update(ProfileHire_params)
        format.html { redirect_to @ProfileHire, notice: 'ProfilesHires was successfully updated.' }
        format.json { render :show, status: :ok, location: @ProfileHire }
      else
        format.html { render :edit }
        format.json { render json: @ProfileHire.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @ProfileHire.destroy
    respond_to do |format|
      format.html { redirect_to profile_hires_url, notice: 'Hired profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile_hire
    @ProfileHire = ProfileHire.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ProfileHire_params
    params.require(:ProfileHire).permit(:jprofile_id, :employer_id)
  end
end
