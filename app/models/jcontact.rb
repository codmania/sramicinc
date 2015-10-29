class Jcontact < ActiveRecord::Base
  belongs_to :employer
  belongs_to :job_application
end
