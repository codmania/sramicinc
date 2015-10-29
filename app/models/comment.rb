class Comment < ActiveRecord::Base
  belongs_to :job
  belongs_to :user


  def commented_user_profile
    if self.user.role.authority == 'jobseeker'
        Jobseeker.find_by(user_id: self.user_id).jprofile
    elsif  self.user.role.authority == 'employer'
        Employer.find_by(user_id: self.user_id).eprofile
    else
        nil
    end
  end
end
