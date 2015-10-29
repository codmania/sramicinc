class Employer < ActiveRecord::Base
  has_many :jobs
  has_many :profile_hires
  has_many :job_applications, through: :jobs
  has_one :eprofile
  belongs_to :user

  has_many :users

  has_one :email_template
end
