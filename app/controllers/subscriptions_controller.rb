class SubscriptionsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index

    if params[:plan_type] == "all" && params[:plan] == "all"

      @subscriptions = Subscription.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)

    elsif params[:plan_type] == "all" && params[:plan] != "all"

      @plans = Plan.where(name: params[:plan])
      @subscriptions = Subscription.where(plan_id: @plans.pluck(:id)).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)

    elsif params[:plan_type] != "all" && params[:plan] == "all"

      @plans = Plan.where(plan_type: params[:plan_type])
      @subscriptions = Subscription.where(plan_id: @plans.pluck(:id)).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)

    else

      @plans = Plan.where(plan_type: params[:plan_type], name: params[:plan])
      @subscriptions = Subscription.where(plan_id: @plans.pluck(:id)).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)


    end


    #else if params[:plan]!="all"

    #@subscriptions = Subscription.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to subscriptions_path, notice: 'Subscription End date was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:start_date,:end_date)
  end
end
