class Skill < ActiveRecord::Base

  belongs_to :jprofile
  validates :name, presence: true, length: {maximum: 100}
  validates_format_of :year_of_experience, presence: true,:with => /\A[0-9]{1,2}(?:[\.]{1}[0-9]{1,2})?\Z/, :message => 'Years should be in xx.xx format'

  #belongs_to :skill_set

  after_save :reindex_jprofile
  before_destroy :reindex_jprofile



  def reindex_jprofile
    Sunspot.index(jprofile)
  end

end
