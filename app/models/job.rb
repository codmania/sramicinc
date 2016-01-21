class Job < ActiveRecord::Base
  belongs_to :employer
  belongs_to :industry
  #belongs_to :category
  belongs_to :state_list
  belongs_to :country_list
  belongs_to :salary_type
  belongs_to :job_type
  has_many :job_applications
  has_many :jobseekers , through: :job_applications
  has_many :comments
  geocoded_by :address_str
  after_validation :geocode
  validates :title, presence: true, length: {maximum: 200}
  validates :city, presence: true, length: {maximum: 100}
  validates_format_of :zip, presence: true,:with => /\A[0-9]{5}$\Z/ ,:message => "is mandatory and should be in 5 digits", if: 'zip.present?'
  validates_format_of :experience,:with => /\A[0-9]{1,2}(?:[\.]{1}[0-9]{1,2})?\Z/, :message => 'should be in xx.xx format', if: 'experience.present?'
  validates :education, length: {maximum:200}, if: 'education.present?'
  validates_format_of :salary, :with => /\A[$][0-9]{1,20}(?:[\.]{1}[0-9]{1,3})?\Z/ ,:message => "should be preceded by '$',max 20 digits before decimal, optional decimal, decimal max 3 digits" ,if: 'salary.present?'
  validates :certification, length: {maximum: 200}, if: 'certification.present?'
  validates :references,length: {maximum: 200}, if: 'references.present?'
  validates :clearance,length: {maximum: 200}, if: 'clearance.present?'
  validates :country_list_id,presence: true
  validates :state_list_id,presence: true
  validates  :description,presence: true,length: {maximum: 20000, :message => "Description is bit big, please enter approx 20000 character's only"}
  before_save :set_city


  def set_city
    if self.city.present?
    self.city = self.city.split.map(&:capitalize).join(' ')
    end
  end


  #after_validation :geocode, :if => :address_str_changed?
  def addr
  str=""
  str+= self.city if self.city!=nil
  str+=', ' if str.length>0
  str+= self.state_list.name if self.state_list!=nil
  str+=', ' if str.length>0
  str+= self.zip if self.zip!=nil
  end
  def address_str
    if self.zip==nil
      #str= self.address+', '+ self.city+', '+ self.state_list.name
      str= self.city+', '+self.state_list.name
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

  searchable do
   # fulltext search
   string :id
   text :title do
     title.try(:downcase)
   end
   text :keywords do
        keywords.split(',').map{|x| x.downcase} if !keywords.nil?
    end
   text :companyname do
     employer.try(:eprofile).try(:company_name).try(:downcase)
   end

   text :plain_description do
     plain_description.split(' ').map{|x| x.downcase} if !plain_description.nil?
   end


   string :plain_description,:multiple => true do
     plain_description.split(' ').map{|x| x.downcase} if !plain_description.nil?
   end

   #Adv search
   string :keywords,:multiple => true do
     keywords.split(',').map{|x| x.downcase} if !keywords.nil?
   end
   string :title do
     title.try(:downcase)
   end

   string :companyname  do
     employer.try(:eprofile).try(:company_name).try(:downcase)
   end
   # string :categoryname do
   #   category.try(:name).try(:downcase)
   # end
   string :industry  do
     employer.try(:eprofile).try(:company_name).try(:downcase)
   end

   string :created_at

   string :job_type  do
   job_type.try(:name).try(:downcase)
   end

   string :industry do
    industry.try(:name).try(:downcase)
   end
   string :city

   string :state do
    state_list.try(:name).try(:downcase)
   end

   string :salary_type do
    salary_type.try(:s_type).try(:downcase)
   end

   latlon :location_latlon

   string :salary

   boolean :status, :stored => true


  end
end
