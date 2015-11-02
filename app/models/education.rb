class Education < ActiveRecord::Base

  belongs_to :jprofile
  validates :degree, presence: true, length: {maximum: 100}
  validates :field, length: {maximum: 100}
  validates :institution, length: {maximum: 200}
  validates :location, length: {maximum: 1000}
  validates :completion, presence: true, length: {maximum: 20}

  #validates_presence_of :qualification_id, :university_id, :discipline_id, :grade_id, :jprofile_id

  # has_one :edu_qualification, :dependent => :destroy
  # has_one :edu_university, :dependent => :destroy
  # has_one :edu_discipline, :dependent => :destroy
  # has_one :edu_grade, :dependent => :destroy
  #
  #
  # has_one :qualification, through: :edu_qualification
  # has_one :university, through: :edu_university
  # has_one :discipline, through: :edu_discipline
  # has_one :grade, through: :edu_grade

  # belongs_to :qualification
  # belongs_to :university
  # belongs_to :discipline
  # belongs_to :grade


  after_save :reindex_jprofile
  before_destroy :reindex_jprofile



  def reindex_jprofile
    Sunspot.index(jprofile)
  end

end
