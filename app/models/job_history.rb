class JobHistory < ActiveRecord::Base

  belongs_to :jprofile
  validate :to_date_cannot_be_less_than_from_date
  validates :title, presence: true, length: {maximum: 100}
  validates :organization, presence: true, length: {maximum: 100}

  def to_date_cannot_be_less_than_from_date
    errors.add(:to, "date can not be lesser than from date") if
      !to.blank? and to < from
  end

  # has_many :experience_sectors
  #
  # belongs_to :salary_type
  #belongs_to :salary



end
