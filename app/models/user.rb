class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable,:trackable, :validatable, :lockable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  devise :timeoutable, :timeout_in => 30.minutes

  belongs_to :role
  belongs_to :security_question
  has_many :employers
  belongs_to :employer
  has_one :industry
  validates_format_of :password, :on => :update, :with=>/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])/,:message => "Should contain atleast one : upper case ,lower case letters,numbers,special characters!!", if: 'password.present?'
  validates_format_of :password, presence: true,:on => :create, :with=>/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])/,:message => "Should contain atleast one : upper case ,lower case letters,numbers,special characters!!"
  validates :name ,presence: true,length: {maximum: 50}

  has_many :networks

  has_many :job_alerts
  has_many :talent_alerts
  has_many :notifications

  has_one :subscription
  has_one :plan, :through => :subscription

  after_create :create_job_seeker_or_emplyer

  def create_job_seeker_or_emplyer

    if self.role.authority == 'employer'
      @emp = Employer.create(user_id: self.id)
      eprofile = Eprofile.new(employer_id: @emp.id,company_name:self.name, email: self.email )
      eprofile.save(validate: false)
      free_subscription_activation('employer')
    elsif self.role.authority == 'jobseeker'
      @jobseeker = Jobseeker.create(user_id: self.id)
      jprofile = Jprofile.new(jobseeker_id:@jobseeker.id,name:self.name, zip: '' )
      jprofile.save(validate: false)
      free_subscription_activation('jobseeker')
    end
  end


  def free_subscription_activation(plan_type)
    #@plan = Plan.where(name: 'FREE', plan_type: plan_type).first
    if(plan_type == 'jobseeker' )
      plan_id = 6
    else
      plan_id = 1
    end
      subscription = Subscription.create(plan_id: plan_id, user_id: self.id, start_date: Time.now)
      PaymentInfo.create(subscription_id: subscription.id)
  end

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.role_id = 3
  #     # user.name = auth.info.name   # assuming the user model has a name
  #     # user.image = auth.info.image # assuming the user model has an image
  #   end
  # end

  def self.from_omniauth(auth, query)
    if  (where(provider: auth.provider, uid: auth.uid).first).nil?
      if (where(email: auth.info.email).first).nil?
        user = User.new
            user.provider = auth.provider
            user.uid= auth.uid
            user.email= auth.info.email
            user.name = auth.info.name
            user.password= Devise.friendly_token[0,20]
            user.confirmed_at= DateTime.now

            # TO Do: Role have to inject here based on login selection
            if query['user'].to_s == "jobseeker"
              user.role_id = 3
            else
              user.role_id = 2
            end

        user.save

      else
        user = User.where(email: auth.info.email).first
            user.provider = auth.provider
            user.uid= auth.uid
            user.save
      end
    else
      user = where(provider: auth.provider, uid: auth.uid).first
    end

    return user

  end

  def self.from_omniauth_checker(auth)
    registered_user = where(provider: auth['provider'], uid: auth['uid']).first

    if registered_user
      return registered_user
    else
      return nil
    end

  end

  def self.save_omniauth(provider, uid, email)
    where(provider: provider, uid: uid).create do |user|
      user.email = email
      user.password = Devise.friendly_token[0,20]
      user.role_id = 3
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

 # to get account status
  def user_account_status
    if self.active?
      'active'
    else
      'deactivate'
    end
  end


  def active_for_authentication?
    super && active?
  end

  def inactive_message
    if !active?
      :not_approved
    else
      super # Use whatever other message
    end
  end


  def profile
    if self.role.authority == 'jobseeker'
       jobseeker = Jobseeker.find_by(user_id: self.id)
       jprofile = Jprofile.find_by(jobseeker_id: jobseeker.id)
    elsif self.role.authority == 'employer'
       employer =  Employer.find_by(user_id: self.id)
       eprofile = Eprofile.find_by(employer_id: employer.id)
    end
  end


  def profile_name
    if self.role.authority == 'jobseeker'
      jobseeker = Jobseeker.find_by(user_id: self.id)
      jprofile = Jprofile.find_by(jobseeker_id: jobseeker.id).name
    elsif self.role.authority == 'employer'
      employer =  Employer.find_by(user_id: self.id)
      eprofile = Eprofile.find_by(employer_id: employer.id).company_name
    end
  end



end
