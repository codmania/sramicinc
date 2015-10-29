class NewsLettersController < ApplicationController
  skip_filter  :authenticate_user!, only: [:new, :create]
  before_action :authenticate_admin_user!, only: [:index, :destroy,:news_letter]
  before_action :set_news_letter, only: [:edit, :update, :destroy]

  # GET /news_letters
  # GET /news_letters.json
  def index
    @news_letters=NewsLetter.all.paginate(:page => params[:page], :per_page => PER_PAGE_COUNT)
  end

  # GET /news_letters/1
  # GET /news_letters/1.json
  def show
   # redirect_to news_letters_newsletter_path
  end

  # GET /news_letters/new
  def new
    @news_letter = NewsLetter.new
  end

  # GET /news_letters/1/edit
  def edit
  end

  def news_letter

    #render :news_letter
  end

  # POST /news_letters
  # POST /news_letters.json
  def create

   @newsletter = NewsLetter.find_by(email: params[:news_letter][:email])
   if !@newsletter.nil?
       if !@newsletter.active
         @newsletter.update_attributes(active: true)
       end
       respond_to do |format|
         format.html { redirect_to new_news_letter_path, notice: 'Email has already been subscribed!!' }
         format.json { render json: @news_letter.errors, status: :unprocessable_entity }
       end
       return
   end

    @news_letter = NewsLetter.new(news_letter_params)
      respond_to do |format|
          if @news_letter.save
              format.html { redirect_to new_news_letter_path, notice: 'Successfully Subscribed for Newsletter!!.' }
              format.json { render :show, status: :created, location: @news_letter }
          else
              format.html { render :new }
              format.json { render json: @news_letter.errors, status: :unprocessable_entity }
          end
      end

   end

  # PATCH/PUT /news_letters/1
  # PATCH/PUT /news_letters/1.json
  def update
    respond_to do |format|
      if @news_letter.update(news_letter_params)
        format.html { redirect_to news_letters_url, notice: 'News letter was successfully updated.' }
        format.json { render :show, status: :ok, location: @news_letter }
      else
        format.html { render :edit }
        format.json { render json: @news_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_letters/1
  # DELETE /news_letters/1.json
  def destroy
    @news_letter.destroy
    respond_to do |format|
      format.html { redirect_to news_letters_url, notice: 'News letter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def active_deactive
    @news = NewsLetter.find(params[:id])
    @news.update_attribute(:active, params[:flag])
    redirect_to news_letters_url

  end

  def send_news_letter
    #TO DO - Email trigger background jobs
    @news_letters = NewsLetter.where(active: true)
    @news_letters.each do |newletter|
          sub = params[:subject]
          @mess = params[:message][0]
          # puts @mess.html
          email = newletter.email
          NewsletterMailer.send_email(sub,@mess,email).deliver_later
    end
    redirect_to news_letters_url, notice: 'News Letter was sent successfully!!'
    #render :text=> 'Message Sent sucessfully', content_type: 'text/plain'
    #render :text => 'send newsletter'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_letter
      @news_letter = NewsLetter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_letter_params
      params.require(:news_letter).permit(:title, :name, :email, :active)
    end
end
