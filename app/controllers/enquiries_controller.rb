class EnquiriesController < ApplicationController

  skip_filter :authenticate_user!, only: [:new, :create, :contactus]
  before_action :authenticate_admin_user!, only: [:index, :destroy]
  before_action :set_enquiry, only: [:destroy]
  # GET /enquiries
  # GET /enquiries.json
  def index
    @enquiries = Enquiry.all.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /enquiries/1
  # GET /enquiries/1.json
  def show
  end

  # GET /enquiries/new
  def new
    @enquiry = Enquiry.new
  end

  # GET /enquiries/1/edit
  def edit
  end

  # POST /enquiries
  # POST /enquiries.json
  def create
    @enquiry = Enquiry.new(enquiry_params)

    respond_to do |format|
      if @enquiry.save
        #format.html { redirect_to enquiries_url, notice: 'Enquiry was successfully created.'}
        format.html { render :contactus, notice: 'Enquiry was successfully created.' }
        #format.json { render :show, status: :created, location: @enquiry }
      else
        format.html { render :new }
        format.json { render json: @enquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enquiries/1
  # PATCH/PUT /enquiries/1.json
  def update
    respond_to do |format|
      if @enquiry.update(enquiry_params)
        format.html { redirect_to enquiries_url, notice: 'Enquiry was successfully updated.' }
        format.json { render :show, status: :ok, location: @enquiry }
      else
        format.html { render :edit }
        format.json { render json: @enquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enquiries/1
  # DELETE /enquiries/1.json
  def destroy
    @enquiry.destroy
    respond_to do |format|
      format.html { redirect_to enquiries_url, notice: 'Enquiry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def contactus

  end

  def message_respond
    @enquiry = Enquiry.find_by_id(params[:eid])
   if  EnquiryMailer.enquiry_email(params[:subject], params[:message][0], @enquiry).deliver_later
    render :text => 'Message Sent sucessfully..', content_type: 'text/plain'
  
    #redirect_to enquiries_url, notice: 'Message Sent sucessfully..'
  end
end



def update_status

  puts params[:status]
  j=Enquiry.find(params[:id])
  if params[:status]
  j.status=params[:status]
  j.respond_date=DateTime.now
  j.save
  render :text => 'responded',content_type: 'text/plain'
  

end
end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_enquiry
    @enquiry = Enquiry.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def enquiry_params
    params.require(:enquiry).permit(:enquiry_category_id, :name, :email, :description,:status)
  end
end
