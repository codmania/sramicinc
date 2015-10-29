class ProfileHire < ActiveRecord::Base
  belongs_to :employer
  belongs_to :jprofile
end
