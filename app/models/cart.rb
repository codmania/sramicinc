class Cart < ActiveRecord::Base

  validates_uniqueness_of :job_id, :scope => :jobseeker_id
  belongs_to :job
  belongs_to :jobseeker

end
