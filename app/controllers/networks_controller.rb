class NetworksController < ApplicationController
  before_action :set_network, only: [:show,:edit,:update, :destroy]

  def index
    @networks = Network.where(me: current_user.id ).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
   
  end

  def show
  end

  def new
    @network = Network.new
  end

  def edit
  end

  def create

    if Network.find_by(user_id: params[:id], me: current_user.id).nil?
        @network = Network.create(user_id: params[:id], me: current_user.id)
        Notification.create(user_id: params[:id], url: "#{request.base_url}/networks", n_type: 'Network')
        message = 'Added to your Network Successfully'
    else
      message = 'Already in your Network..!!'
    end

    str = ''
    if params[:offset]=='1'
      str= ApplicationHelper.params_constructions_jprofile(params)
    end


    respond_to do |format|
        format.html{

          if !params[:eprofile_id].nil?
            redirect_to jobs_job_eprofile_path(:id => params[:eprofile_id]), :flash => {:notice => message}
          elsif !params[:jprofile_id].nil?
            redirect_to employer_talents_path(:id => params[:jprofile_id])+str, :flash => {:notice => message}
          end
        }
        format.json{render :show, status: :created, location: @network}
    end
  end

    def update
      respond_to do |format|
      if @network.update(network_params)
        format.html { redirect_to @network, notice: 'network was successfully updated.' }
        format.json { render :show, status: :ok, location: @network }
      else
        format.html { render :edit }
        format.json { render json: @network.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
     @network.destroy
    respond_to do |format|
      format.html { redirect_to networks_url, notice: 'network was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_network
    @network = Network.find(params[:id])
  end

  # def network_params
  #   params.require(:network).permit(:jobseeker_id,:employer_id)
  # end

end
