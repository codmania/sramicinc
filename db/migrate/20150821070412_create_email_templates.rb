class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|

      t.text :subject
      t.text :body
      t.integer :employer_id
      t.timestamps null: false
    end
  end
end
