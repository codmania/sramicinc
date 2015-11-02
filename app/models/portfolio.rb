class Portfolio < ActiveRecord::Base
  belongs_to :jprofile
  #belongs_to :skill_set
  validates :name, presence: true, length: {maximum: 100}
  validates :url,length: {maximum: 256}
  after_save :reindex_jprofile
  before_destroy :reindex_jprofile
  has_attached_file :logo, :styles => { :medium => "200x200>", :thumb => "100x100>" }
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  def reindex_jprofile
    Sunspot.index(jprofile)
  end
end
