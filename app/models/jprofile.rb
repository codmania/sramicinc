class Jprofile < ActiveRecord::Base
  belongs_to :jobseeker

  has_many :educations
  has_many :certifications
  has_one :job_histories
  has_many :skills
  has_many :journals
  has_many :portfolios
  belongs_to :salary_type
  belongs_to :state_list
  belongs_to :country_list

  validates :title, presence: true, length: {maximum: 200}
  validates :name, presence: true, length: {maximum: 200}
  validates :address1, presence: true, length: {maximum: 1000}
  validates :address2, length: {maximum: 1000}, if: 'address2.present?'
  validates :city, presence: true, length: {maximum: 100}
  validates_format_of :zip, presence: true,:with => /\A[0-9]{5}$\Z/ ,:message => "is mandatory and should be in 5 digits"
  validates_format_of :phone, presence: true,:with => /\A([\+]?[1]{1})?(?:[\(][0-9]{3}[\)]|[0-9]{3})[\-]?[0-9]{3}[\-]?[0-9]{4}\Z/, :message => 'Number Format:Any 10 digit numbers, 123-456-7890 ,(123)456-7890,+11234567890'
  validates_format_of :salary, :with => /\A[0-9]{1,20}(?:[\.]{1}[0-9]{1,3})?\Z/ ,:message => "max 20 digits before decimal, optional decimal, decimal max 3 digits" ,if: 'salary.present?'
  validates  :summary,presence: true,length: {maximum: 20000}


  before_save :set_city

  def set_city
    if self.city.present?
    self.city = self.city.split.map(&:capitalize).join(' ')
      end
  end


  #validates_format_of :phone, :with => /\A^((\+91?)|0)?[789][0-9]{9}$\Z/, :message => "Number Should be in 10 digits beginning with 9 or 8 or 7 with +91 optional"
  #validates_format_of :zip, :with => /\A[0-9]{6}$\Z/, :message => "should be in digits and 6 digits"

 has_attached_file :resume
 #do_not_validate_attachment_file_type :resume

  geocoded_by :address_str
  after_validation :geocode

  # has_attached_file :logo, :styles => { :medium => "200x200>", :thumb => "50x50>" }, :default_url => "medium/jprofile_missing.png"
  # validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/


  has_attached_file :logo, :styles => { :medium => "200x200>", :thumb => "50x50>" }, :default_url => "medium/default_image.png"

  validates_attachment :logo, :size => { :in =>0..3.megabytes,
                                                            :message => "logo must be less than 3MB!!" },
                       :content_type => {:content_type => /\Aimage\/.*\Z/, :message => "logo should be image only!"}


  validates_attachment :resume, :size => { :in =>0..3.megabytes,
                                                              :message => "attachment must be less than 3MB!" },
                       :content_type => {:content_type => ['application/pdf' ,'application/msword' ,'application/vnd.openxmlformats-officedocument.wordprocessingml.document'], :message => "file should be pdf or word only!!"}

  # validates_attachment :resume, :presence => true, :size => { :in =>0..3.megabytes,
  # 	                                               :message => "File size must be less than 3MB are allowed" },
  # 	                   :content_type => {:content_type => ['application/pdf' , 'application/kswps']}

   def addr
     str=""
     str+= self.city if self.city!=nil
     str+=', ' if str.length>0
     str+= self.state_list.name if self.state_list.name!=nil
     str+=', ' if str.length>0
     str+= self.zip if self.zip!=nil
   end

  def address_str
    if self.zip==nil
      str= self.city+' ,'+self.state_list.name
    else
      str=self.zip
     end
    str
  end

  def location_latlon
    if self.latitude && self.longitude
      return Sunspot::Util::Coordinates.new(self.latitude, self.longitude)
    else
      return nil
    end
  end

  def user_active
    return jobseeker.user.try(:active)

  end

  searchable do

   boolean :user_active

   text :title do
     title.try(:downcase)
   end
   string :title do
     title.try(:downcase)
   end
=begin
   string :city do
     city.try(:downcase)
   end
=end

   string :city
   string :state do
     state_list.try(:name).try(:downcase)
   end
   latlon :location_latlon

   text :skills do
     skills.map { |skill| skill.name.downcase}
   end

   string :skills, :multiple => true do
     skills.map { |skill| skill.name.downcase }
   end

   text :educations do
     educations.map { |education| education.degree.downcase }
   end

   string :educations, :multiple => true do
     educations.map { |education| education.degree.downcase }
   end

   string :salary_type do
     salary_type.try(:s_type).try(:downcase)
   end

   string :salary

   string :created_at
   string :updated_at
  end


end
