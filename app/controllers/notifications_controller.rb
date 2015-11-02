class NotificationsController < ApplicationController

  def index
    @notifications = Notification.where(user_id: current_user.id ).paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  def show
  end

  def new
    @notification = Notification.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy

    puts params

    @notifications = Notification.where(id: params[:id], user_id: current_user.id, n_type: params[:n_type])

    if !@notifications.empty?
        @notifications.each { |notification|
          notification.destroy
        }
    end

    render :text => 'destroyed'

  end


end
