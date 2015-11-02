class TalentAlertsController < ApplicationController
  before_action :authenticate_employer_user!
  before_action :set_talent_alert, only: [:show, :edit, :update, :destroy]

  # GET /talent_alerts
  # GET /talent_alerts.json
  def index
    @talent_alerts = TalentAlert.all
  end

  # GET /talent_alerts/1
  # GET /talent_alerts/1.json
  def show
  end

  # GET /talent_alerts/new
  def new
    @talent_alert = TalentAlert.new
  end

  # GET /talent_alerts/1/edit
  def edit
  end

  # POST /talent_alerts
  # POST /talent_alerts.json
  def create
    @talent_alert = TalentAlert.new(talent_alert_params)

    respond_to do |format|
      if @talent_alert.save
        format.html { redirect_to talent_alerts_path, notice: 'Talent alert was successfully created.' }
        format.json { render :show, status: :created, location: @talent_alert }
      else
        format.html { render :new }
        format.json { render json: @talent_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /talent_alerts/1
  # PATCH/PUT /talent_alerts/1.json
  def update
    respond_to do |format|
      if @talent_alert.update(talent_alert_params)
        format.html { redirect_to talent_alerts_path, notice: 'Talent alert was successfully updated.' }
        format.json { render :show, status: :ok, location: @talent_alert }
      else
        format.html { render :edit }
        format.json { render json: @talent_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talent_alerts/1
  # DELETE /talent_alerts/1.json
  def destroy
    @talent_alert.destroy
    respond_to do |format|
      format.html { redirect_to talent_alerts_url, notice: 'Talent alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_talent_alert
      @talent_alert = TalentAlert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def talent_alert_params
      params.require(:talent_alert).permit(:what, :where, :within, :user_id)
    end
end
