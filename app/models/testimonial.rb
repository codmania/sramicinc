class Testimonial < ActiveRecord::Base
  belongs_to :user
  has_attached_file :logo, :styles => { :medium => "200x200>", :thumb => "50x50>" }#, :default_url => "medium/missing.png"

  validates_attachment :logo, :size => { :in =>0..1.megabytes,
                                         :message => "must be less than 3MB are allowed" },
                       :content_type => {:content_type => /\Aimage\/.*\Z/, :message => "file should be image only!!"}
end
