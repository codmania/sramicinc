class JobApplication < ActiveRecord::Base
  validates_uniqueness_of :job_id, :scope => :jobseeker_id
  belongs_to :job
  belongs_to :jobseeker
  has_many :jcontacts


  def user_details
    jobseeker = Jobseeker.find(self.jobseeker_id)
    user = User.find(jobseeker.user_id)
  end
end
