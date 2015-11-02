class AddIndexToFaq < ActiveRecord::Migration
  def change
    add_index :faqs, :faq_category_id
  end
end
