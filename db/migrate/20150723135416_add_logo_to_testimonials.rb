class AddLogoToTestimonials < ActiveRecord::Migration
  def change
    add_attachment :testimonials, :logo
  end
end
