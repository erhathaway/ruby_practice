class CreateMeetupEvents < ActiveRecord::Migration
  def change
     create_table :meetup_events do |t|
       t.string :event_name, null: false
       t.string :meetup_group_id, null: false
       t.string :location, null: false

      	t.timestamps
     end
  end
end
