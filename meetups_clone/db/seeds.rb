# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')


User.create(username: 'ethan', provider: 'google', uid: '55u', email: 'erhathaway@gmail.com', avatar_url: 'google.com/img')
User.create(username: 'bob', provider: 'google', uid: '545u', email: 'bob@gmail.com', avatar_url: 'google.com/img')
User.create(username: 'django', provider: 'google', uid: '553u', email: 'erhathaway@gmail.com', avatar_url: 'google.com/img')


MeetupGroup.create(name: "Anti-parks", description: "Green is waste!")
MeetupGroup.create(name: "Pro-parks", description: "Buildings not in my backyard")
MeetupGroup.create(name: "Squirl lovers", description: "More squirls, less cats!")


MeetupEvent.create(event_name: 'moon walk', meetup_group_id: MeetupGroup.where(name: 'Anti-parks').take.id, location: 'moon')
MeetupEvent.create(event_name: 'sun watch', meetup_group_id: MeetupGroup.where(name: 'Pro-parks').take.id, location: 'just outside the sun')

GroupUser.create(user_id: User.where(username: 'ethan').take.id, group_id: MeetupGroup.where(name: 'Pro-parks').take.id)
GroupUser.create(user_id: User.where(username: 'bob').take.id, group_id: MeetupGroup.where(name: 'Squirl lovers').take.id)

EventUser.create(user_id: User.where(username: 'ethan').take.id, event_id: MeetupEvent.where(event_name: 'moon walk').take.id)
EventUser.create(user_id: User.where(username: 'django').take.id, event_id: MeetupEvent.where(event_name: 'moon walk').take.id)