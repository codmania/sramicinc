class StaffsController < ApplicationController
  before_action :authenticate_employer_user!
  before_action :check_staff_user!
  before_action :user_subscription_validate_staff_user_creation!, only:[:new, :create],  if: :payment_module_activated

  def index
    @users = User.all.where(employer_id: session['employer']).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  def new

  end

  def create

    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:conf_password]
    @user.role_id = Role.find_by(authority: 'staff').id
    @user.employer_id = session['employer']
    @user.confirmed_at = DateTime.now

    respond_to do |format|
      if @user.save
        format.html { redirect_to staffs_url, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

    puts params[:password].empty?
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if !params[:password].empty? || !params[:conf_password].empty?
      @user.password = params[:password]
      @user.password_confirmation = params[:conf_password]
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to staffs_url, notice: 'User was successfully created.' }
      else
        format.html { render action: "edit" }
      end
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Skill was successfully destroyed.' }
    end
  end

  def active_deactive

    puts params
    @u = User.find(params[:id])
    @u.update_attribute(:active, params[:flag])

    redirect_to staffs_url, notice: 'User was successfully updated.'
  end

end
