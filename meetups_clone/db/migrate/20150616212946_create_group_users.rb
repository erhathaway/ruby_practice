class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.integer :user_id, null: false
      t.integer :group_id, null: false
    end
  end
end
