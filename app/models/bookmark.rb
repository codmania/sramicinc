class Bookmark < ActiveRecord::Base
	validates_uniqueness_of :jobseeker_id, :scope => :employer_id
  belongs_to :jobseeker
  belongs_to :employer
end
