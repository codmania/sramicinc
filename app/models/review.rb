class Review < ActiveRecord::Base

  has_many :review_responses
  belongs_to :user


  def review_from
    @user = User.find_by(id: self.from)
    if @user.role.authority == 'jobseeker'
      Jobseeker.find_by(user_id: @user.id).jprofile
    elsif @user.role.authority == 'employer'
      Employer.find_by(user_id: @user.id).eprofile
    else
      nil
    end
  end
  
  def review_to
    @user = User.find_by(id: self.to)
    if @user.role.authority == 'jobseeker'
      Jobseeker.find_by(user_id: @user.id).jprofile
    elsif @user.role.authority == 'employer'
      Employer.find_by(user_id: @user.id).eprofile
    else
      nil
    end
  end


  def review_from_user_role
    @user = User.find_by(id: self.from)
    if @user.role.authority == 'jobseeker'
      'jobseeker'
    elsif @user.role.authority == 'employer'
      'employer'
    else
      nil
    end
  end

  def review_to_user_role
    @user = User.find_by(id: self.to)
    if @user.role.authority == 'jobseeker'
      'jobseeker'
    elsif @user.role.authority == 'employer'
      'employer'
    else
      nil
    end
  end


end
