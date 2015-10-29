class Eprofile < ActiveRecord::Base
  belongs_to :employer
  belongs_to :industry
  belongs_to :state_list
  belongs_to :country_list
  has_many :reviews
  has_many :bookmarks
  has_many :questionaires
  has_many :shares
  validates :company_name, presence: true, length: {maximum: 100}
  validates :services, length: {maximum: 1000}, if: 'services.present?'
  validates :products, length: {maximum: 1000}, if: 'products.present?'
  validates :address1, presence: true, length: {maximum: 1000}
  validates :address2, length: {maximum: 1000}, if: 'address2.present?'
  validates :city, length: {maximum: 50}, if: 'city.present?'
  validates_format_of :phone, :allow_blank=>true,:with => /\A([\+]?[1]{1})?(?:[\(][0-9]{3}[\)]|[0-9]{3})[\-]?[0-9]{3}[\-]?[0-9]{4}\Z/, :message => 'Number Format:Any 10 digit numbers, 123-456-7890 ,(123)456-7890,+11234567890', if: 'phone.present?'
  validates_format_of :fax, :with => /\A[0-9]{3}\-[0-9]{7}\Z/, :message => "should be in format like (area code-fax number)", if: 'fax.present?'
  validates  :overview,length: {maximum: 2000}, if: 'overview.present?'
  validates_format_of :website,:allow_blank=>true, length: {maximum: 256},:with => /\A((https?\:\/\/|www\.)(?:[-a-z0-9]+\.)*[-a-z0-9]+.*)\Z/, :message =>"Format Should be anything that starts with http:// 'or' https:// 'or' www.", if: 'website.present?'
  validates_format_of :fb_url,:allow_blank=>true, length: {maximum: 1000},:with => /\A^(https?:\/\/)?((w{3}\.)?)facebook.com\/.*\Z/, :message =>"Format Should be anything that starts with http(s)://www.facebook.com/", if: 'fb_url.present?'
  validates_format_of :twitter_url, :allow_blank=>true,length: {maximum: 1000},:with => /\A^(https?:\/\/)?((w{3}\.)?)twitter\.com\/(#!\/)?[a-z0-9_]+$\Z/, :message =>"Format Should be anything that starts with http(s)://www.twitter.com/", if: 'twitter_url.present?'
  validates_format_of :gplus_url,:allow_blank=>true, length: {maximum: 1000},:with => /\A^(https?:\/\/)?((w{3}\.)?)plus\.google\.com\/(#!\/)?[a-z0-9_]+$\Z/, :message =>"Format Should be anything that starts with http(s)://www.plus.google.com/", if: 'gplus_url.present?'
  validates_format_of :linkedin_url, :allow_blank=>true,length: {maximum: 1000},:with => /\A^(https?:\/\/)?((w{3}\.)?)linkedin\.com\/(#!\/)?[a-z0-9_]+$\Z/, :message =>"Format Should be anything that starts with http(s)://www.linkedin.com/", if: 'linkedin_url.present?'


  before_save :set_city


  def set_city
    if self.city.present?
    self.city = self.city.split.map(&:capitalize).join(' ')
    end
  end


  has_attached_file :logo, :styles => { :medium => "200x200>", :thumb => "10x10#" }, :default_url => "medium/default_image.png"

  validates_attachment :logo, :size => { :in =>0..1.megabytes,
                                         :message => "must be less than 3MB are allowed" },
                       :content_type => {:content_type => /\Aimage\/.*\Z/, :message => "file should be image only"}



end
