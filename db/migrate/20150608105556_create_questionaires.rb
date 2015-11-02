class CreateQuestionaires < ActiveRecord::Migration
  def change
    create_table :questionaires do |t|
      t.text :question
      t.text :answer
      t.integer :user_id
      t.integer :eprofile_id

      t.timestamps null: false
    end
  end
end
