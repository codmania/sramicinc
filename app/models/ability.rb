class Ability
  include CanCan::Ability

  def initialize(user)

    if user.role.authority == 'jobseeker'
       jobseeker = Jobseeker.find_by(user: user)
       jproifle = Jprofile.find_by(jobseeker: jobseeker)
       can [:read, :create], [Skill, Education, JobHistory, Certification, Portfolio, Journal]
       can [:update, :destroy], [Skill, Education, JobHistory, Certification, Portfolio, Journal], :jprofile_id => jproifle.id

    end
  end
end
