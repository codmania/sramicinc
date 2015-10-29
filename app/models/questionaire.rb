class Questionaire < ActiveRecord::Base
	belongs_to :user
	belongs_to :eprofile
end
