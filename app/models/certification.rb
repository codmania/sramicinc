class Certification < ActiveRecord::Base
  belongs_to :jprofile
  validate :expiry_date_cannot_be_less_than_recieved_date
  validates :name, presence: true, length: {maximum: 100}
  validates :institution,length: {maximum: 200}

  def expiry_date_cannot_be_less_than_recieved_date
    errors.add(:expired, "Expiry date can not be lesser than Recieved date") if
      !expired.blank? and expired < received
  end
end
