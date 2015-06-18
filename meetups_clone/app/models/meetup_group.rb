class MeetupGroup < ActiveRecord::Base
  has_many :users, through: :group_user
  has_many :meetup_events
  
  validates :name, presence: true
  validates :description, presence: true
end
