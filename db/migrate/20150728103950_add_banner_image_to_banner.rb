class AddBannerImageToBanner < ActiveRecord::Migration
  def change
    add_attachment :banners, :banner_image
  end
end
