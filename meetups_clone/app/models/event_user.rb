class EventUser < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  #check whether a user is also part of a group that the event is part of
  validates :checker, inclusion: { in: [true] }
  def checker
  	user_in_group = false
  	event = MeetupEvent.find(self.event_id)
	group = MeetupGroup.find(event.meetup_group_id)
	if group
	  	user_in_group = GroupUser.where(group_id: group.id, user_id: self.user_id).any?
	end
	return user_in_group
  end	

end
