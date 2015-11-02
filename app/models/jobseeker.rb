class Jobseeker < ActiveRecord::Base

  has_one :jprofile
  has_many :job_applications
  has_many :jcontacts, through: :job_applications
  belongs_to :user

end
