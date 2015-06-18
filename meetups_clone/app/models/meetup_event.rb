class MeetupEvent < ActiveRecord::Base
  has_many :users, through: :event_user
  belongs_to :meetup_group

  validates :event_name, presence: true
  validates :meetup_group, presence: true
  validates :location, presence: true
end
