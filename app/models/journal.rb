class Journal < ActiveRecord::Base
  belongs_to :jprofile
validates :name, presence: true, length: {maximum: 1000}
validates :reference,length: {maximum: 1000}

end
