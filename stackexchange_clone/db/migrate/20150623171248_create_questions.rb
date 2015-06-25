class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
    	t.string :title, null: false
    	t.text :question, null: false
    	t.integer :votes, default: 0
    	t.integer :views, default: 0
    	# t.integer :user_id, null: false

    	t.timestamps null: false
    end
  end
end
