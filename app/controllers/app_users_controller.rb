class AppUsersController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_app_user, only: [:show, :edit, :update, :destroy]

  # GET /app_users
  # GET /app_users.json
  def index

        if params[:user_type] == '2' || params[:user_type] == '3'
            role_type=params[:user_type]
        else
            role_type=[2,3]
        end

        role_name=params[:name]
        @users = User.where("role_id IN (?) AND name like ?",role_type,"%#{role_name}%").paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /app_users/1
  # GET /app_users/1.json
  def show
  end

  # GET /app_users/new
  def new
    @user = User.new
  end

  # GET /app_users/1/edit
  def edit
  end

  # POST /app_users
  # POST /app_users.json
  def create
    @user = User.new(app_user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to app_users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @app_user }
      else
        format.html { render :new }
        format.json { render json: @app_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_users/1
  # PATCH/PUT /app_users/1.json
  def update
    respond_to do |format|
      if @user.update(app_user_params)
        format.html { redirect_to app_users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_users/1
  # DELETE /app_users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to app_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def active_deactive

    puts params
    @u = User.find(params[:id])
    @u.update_attribute(:active, params[:flag])

     redirect_to app_users_url, notice: 'User was successfully updated.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_app_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def app_user_params
    params.require(:user).permit(:name)
  end
end
