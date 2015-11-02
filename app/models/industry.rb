class Industry < ActiveRecord::Base
	has_many :eprofiles
	belongs_to :user

  has_many :jobs
end
