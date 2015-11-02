class JobAlert < ActiveRecord::Base
  belongs_to :user
  validates :what ,presence: true,length: {maximum: 150}
#  validates :where ,presence: true,length: {maximum: 150}
end
