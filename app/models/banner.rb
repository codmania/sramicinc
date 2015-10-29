class Banner < ActiveRecord::Base


  has_attached_file :banner_image, :styles => { :medium => "200x200>", :thumb => "50x50>" }, :default_url => "medium/missing.png"

  validates_attachment :banner_image, :size => { :in =>0..1.megabytes,
                                         :message => "must be less than 3MB are allowed" },
                       :content_type => {:content_type => /\Aimage\/.*\Z/, :message => "is not in correct format!!"}
  def banner_status
    if self.active?
      'Active'
    else
      'De-active'
    end
  end
end
