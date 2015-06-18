class CreateMeetupGroups < ActiveRecord::Migration
  def change
    create_table :meetup_groups do |t|
      t.string :name, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
