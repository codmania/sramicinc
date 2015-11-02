class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
    	t.integer :faq_category_id
    	t.text :question
    	t.text :answer
      t.timestamps null: false
    end
  end
end
